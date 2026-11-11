#!/usr/bin/env bash
# 공용 Mac 개발환경 도구. 사용자 SSH/계정/원격 설정은 변경하지 않습니다.
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"

usage() {
  cat <<'USAGE'
사용법: bash setup.sh [--check|--plan|--install|--install-extras|--help]
  --check           설치된 도구를 확인만 함 (기본값)
  --plan            Homebrew 설치 대상 목록을 보여줌
  --install         Brewfile의 공용 기본 도구만 설치
  --install-extras  Brewfile.optional의 선택 도구만 설치
  --help            사용법 표시

주의: 이 스크립트는 Homebrew/Xcode CLT를 자동 설치하거나 계정에 로그인하지 않습니다.
USAGE
}

if [[ "$(uname -s)" != "Darwin" ]]; then
  printf 'macOS 전용 스크립트입니다. 현재 OS: %s\n' "$(uname -s)" >&2
  exit 2
fi

check_command() {
  local label="$1" binary="$2"
  if command -v "$binary" >/dev/null 2>&1; then
    printf '[OK]     %-17s (%s)\n' "$label" "$(command -v "$binary")"
  else
    printf '[MISSING] %-17s\n' "$label"
  fi
}

check_tools() {
  printf '현재 macOS 개발환경 확인 (설정 변경 없음)\n\n'
  if xcode-select -p >/dev/null 2>&1; then
    printf '[OK]     Xcode CLT\n'
  else
    printf '[MISSING] Xcode CLT — 먼저 xcode-select --install\n'
  fi
  for tool in brew git gh node npm pnpm python3 uv jq; do
    check_command "$tool" "$tool"
  done
  if command -v code >/dev/null 2>&1 || [[ -d "/Applications/Visual Studio Code.app" ]]; then
    printf '[OK]     VS Code (CLI 또는 앱)\n'
  else
    printf '[MISSING] VS Code\n'
  fi
  printf '\n원격 로그인, SSH 키, GitHub 로그인은 변경하거나 검사하지 않습니다.\n'
}

check_brew() {
  if ! command -v brew >/dev/null 2>&1; then
    printf 'Homebrew가 없습니다. https://brew.sh/ 공식 안내에서 먼저 설치하세요.\n' >&2
    exit 1
  fi
}

show_plan() {
  printf '%s\n' '기본 설치 대상 (Brewfile):'
  cat "$ROOT_DIR/Brewfile"
  printf '\n%s\n' '선택 설치 대상 (Brewfile.optional):'
  cat "$ROOT_DIR/Brewfile.optional"
  printf '\n--plan은 실제 설치하지 않습니다.\n'
}

install_bundle() {
  local file="$1"
  check_brew
  if ! xcode-select -p >/dev/null 2>&1; then
    printf '먼저 Xcode CLT를 설치하세요: xcode-select --install\n' >&2
    exit 1
  fi
  printf '다음 파일의 패키지 설치를 시작합니다: %s\n' "$(basename "$file")"
  brew bundle --file="$file"
  printf '설치 명령이 종료되었습니다. bash setup.sh --check 로 확인하세요.\n'
}

if [[ "$#" -eq 0 ]]; then
  set -- --check
fi
case "$1" in
  --check) check_tools ;;
  --plan) show_plan ;;
  --install) install_bundle "$ROOT_DIR/Brewfile" ;;
  --install-extras) install_bundle "$ROOT_DIR/Brewfile.optional" ;;
  --help|-h) usage ;;
  *) usage >&2; exit 2 ;;
esac
