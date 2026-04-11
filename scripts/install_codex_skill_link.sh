#!/usr/bin/env bash

set -euo pipefail

usage() {
  cat <<'EOF'
Usage:
  bash scripts/install_codex_skill_link.sh [--check] [--force]

Options:
  --check   Verify that ~/.agents/skills/clo-author points to this repo's skill bundle.
  --force   Replace an existing ~/.agents/skills/clo-author entry if it points elsewhere.
EOF
}

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source_dir="$repo_root/plugins/clo-author/skills"
target_dir="${HOME}/.agents/skills"
target_link="$target_dir/clo-author"

check_only=false
force=false

for arg in "$@"; do
  case "$arg" in
    --check)
      check_only=true
      ;;
    --force)
      force=true
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown option: $arg" >&2
      usage >&2
      exit 1
      ;;
  esac
done

if [[ ! -d "$source_dir" ]]; then
  echo "Source skill directory not found: $source_dir" >&2
  exit 1
fi

current_target=""
if [[ -L "$target_link" ]]; then
  current_target="$(readlink "$target_link")"
fi

if $check_only; then
  if [[ -L "$target_link" && "$current_target" == "$source_dir" ]]; then
    echo "OK: $target_link -> $source_dir"
    exit 0
  fi

  if [[ -e "$target_link" || -L "$target_link" ]]; then
    echo "FAIL: $target_link exists but does not point to $source_dir" >&2
  else
    echo "FAIL: $target_link is missing" >&2
  fi
  exit 1
fi

mkdir -p "$target_dir"

if [[ -L "$target_link" && "$current_target" == "$source_dir" ]]; then
  echo "Already installed: $target_link -> $source_dir"
  echo "Restart Codex and confirm the 10 Clo-Author skills are visible."
  exit 0
fi

if [[ -e "$target_link" || -L "$target_link" ]]; then
  if ! $force; then
    echo "Refusing to replace existing $target_link without --force" >&2
    exit 1
  fi
  rm -rf "$target_link"
fi

ln -s "$source_dir" "$target_link"

echo "Installed: $target_link -> $source_dir"
echo "Next step: restart Codex, open this repo, and confirm the 10 Clo-Author skills are visible."
