# MacBook 개발환경 시작하기 🍎

맥북으로 개발을 처음 시작하는 사람을 위한 **기본 개발 도구 설치 안내**입니다.

Git, GitHub CLI, Node.js, Python, VS Code를 한곳에서 확인하고 필요한 것만 설치할 수 있도록 만들었습니다. 수업 동료들과 함께 참고하기 위한 자료이며, 특정 개인의 Mac 설정을 복사하지 않습니다.

**대상:** Apple Silicon(M1~) 및 Intel Mac, macOS. **개인 계정·SSH·원격 접속·Tailscale·AI Agent는 설정하지 않습니다.**

## 설치되는 도구

| 도구 | 무엇에 쓰나요? |
|---|---|
| Xcode Command Line Tools | macOS에서 Git 등의 개발 도구를 사용하기 위한 기본 도구 *(별도 수동 설치)* |
| Homebrew | macOS 패키지 관리자 *(별도 수동 설치)* |
| Git | 코드 변경 기록 및 GitHub 협업 |
| GitHub CLI (`gh`) | 터미널에서 GitHub 관리 |
| Node.js · npm · pnpm | JavaScript/TypeScript 개발 |
| Python · uv | Python 개발과 가상환경/패키지 관리 |
| Visual Studio Code | 코드 편집기 |
| jq | JSON 데이터 확인 |

추가로 tmux, ripgrep, fzf, fnm(프로젝트별 Node 버전 관리)을 원하는 사람만 설치할 수 있습니다.

## 1. 최초 1회: macOS 기본 개발 도구

**터미널**(Spotlight에서 `Terminal` 검색)을 열고 실행하세요.

```bash
xcode-select --install
```

이미 설치되어 있다면 안내만 표시될 수 있습니다. 설치 대화상자가 나오면 Apple 안내에 따라 설치하세요.

그다음 [Homebrew 공식 사이트](https://brew.sh/)에서 현재 제공하는 설치 안내를 따라 설치하세요. 설치가 끝나면 사이트에서 안내하는 **PATH 설정**도 적용해야 `brew` 명령을 인식합니다.

확인:

```bash
xcode-select -p
brew --version
```

## 2. 이 저장소를 받아서 상태부터 확인

```bash
git clone https://github.com/ju0o/MacBook_Dev.git
cd MacBook_Dev
bash setup.sh --check
```

`--check`는 설치·설정 변경 없이, 지금 설치된 도구를 확인합니다. `--plan`은 설치 대상 목록만 보여줍니다.

```bash
bash setup.sh --plan
```

## 3. 필요한 도구 설치

설치할 도구를 확인했다면 **사용자가 직접** 다음을 실행하세요.

```bash
bash setup.sh --install
```

이 명령은 `Brewfile`에 적힌 패키지만 Homebrew로 설치합니다. **비밀번호를 저장하지 않고**, 기존 SSH 키·Git 설정·Mac 공유 권한·로그인 항목을 수정하지 않습니다. VS Code 설치 등 macOS 확인창이 나타날 수 있습니다.

설치 후 다시 확인:

```bash
bash setup.sh --check
```

> 이미 설치된 도구가 있다면 Homebrew가 상태를 확인합니다. 수업에서 별도 버전을 지정했다면 강제로 전체 설치하기 전에 담당 강사의 버전 안내를 우선하세요. 프로젝트마다 Node/Python 버전이 다를 수 있습니다.

## 선택 사항: 터미널 도구 더하기

```bash
bash setup.sh --install-extras
```

`Brewfile.optional`에 정의된 tmux(터미널 세션), ripgrep(빠른 코드 검색), fzf(대화형 검색), fnm(Node 버전 관리 도구)을 설치합니다. **선택 사항**이며 초기 개발에는 없어도 됩니다.

## 설치 후 한 번 확인해 볼 것

```bash
git --version
gh --version
node --version
npm --version
pnpm --version
python3 --version
uv --version
```

VS Code의 터미널에서 `code` 명령이 안 되면 VS Code 명령 팔레트(`Cmd + Shift + P`)에서 `Shell Command: Install 'code' command in PATH`를 찾아 실행해 보세요. 설치 방식에 따라 메뉴가 다를 수 있습니다.

GitHub 사용을 원한다면 터미널에서 다음 명령을 실행해 **본인 계정**으로 로그인하세요.

```bash
gh auth login
```

로그인 암호, 액세스 토큰, SSH 개인키, `.env` 파일은 GitHub에 업로드하거나 다른 사람에게 공유하지 마세요.

## 자주 묻는 질문

**Q. 이걸 실행하면 Mac 전체 설정이 바뀌나요?**  
아니요. `--check`와 `--plan`은 읽기 전용이고 `--install`은 지정한 Homebrew 패키지만 설치합니다. macOS 원격 로그인, VPN, 절전 모드, 사용자 계정, 터미널/셸 프로필은 자동 변경하지 않습니다.

**Q. Intel Mac도 되나요?**  
Homebrew 지원 macOS 버전이라면 사용할 수 있습니다. Homebrew 경로는 Apple Silicon의 `/opt/homebrew`, Intel의 `/usr/local`처럼 다를 수 있으니 설치 안내에 따라 PATH를 설정하세요.

**Q. Codex, Claude, Paseo도 설치하나요?**  
아니요. AI 코딩 도구는 서비스별 로그인·요금제·권한이 달라서 공용 기본 설치에서 제외했습니다. 필요할 때 각 공식 안내에 따라 별도로 설치하세요.

**Q. GitHub 로그인과 프로젝트 복제는 자동으로 하나요?**  
아니요. 개인 계정 인증이나 특정 프로젝트 복제는 하지 않습니다.

---

### 검증 범위

이 구성의 셸 문법은 검증할 수 있지만 **실제 다른 사람의 Mac에 설치해본 결과는 아닙니다.** Homebrew/VS Code의 설치 대화상자나 macOS 버전별 차이는 각 기기에서 직접 확인해야 합니다.

### 라이선스

공개 학습 자료로 먼저 공유했습니다. 코드 재사용·재배포 라이선스는 아직 별도로 지정하지 않았습니다.
