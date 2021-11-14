# Bash completion script for brew(1)

__brewcomp_words_include() {
  local i=1
  while [[ "${i}" -lt "${COMP_CWORD}" ]]
  do
    if [[ "${COMP_WORDS[i]}" = "$1" ]]
    then
      return 0
    fi
    (( i++ ))
  done
  return 1
}

# Find the previous non-switch word
__brewcomp_prev() {
  local idx="$((COMP_CWORD - 1))"
  local prv="${COMP_WORDS[idx]}"
  while [[ "${prv}" = -* ]]
  do
    (( idx-- ))
    prv="${COMP_WORDS[idx]}"
  done
  echo "${prv}"
}

__brewcomp() {
  # break $1 on space, tab, and newline characters,
  # and turn it into a newline separated list of words
  local list s sep=$'\n' IFS=$' \t\n'
  local cur="${COMP_WORDS[COMP_CWORD]}"

  for s in $1
  do
    __brewcomp_words_include "${s}" && continue
    list="${list}${s}${sep}"
  done

  IFS="${sep}"
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${list}" -- "${cur}")
}

# Don't use __brewcomp() in any of the __brew_complete_foo functions, as
# it is too slow and is not worth it just for duplicate elimination.
__brew_complete_formulae() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local formulae
  formulae="$(brew formulae)"
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${formulae}" -- "${cur}")
}

__brew_complete_casks() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local casks
  casks="$(brew casks)"
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${casks}" -- "${cur}")
}

__brew_complete_installed_formulae() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local installed_formulae
  installed_formulae="$(command ls "$(brew --cellar)" 2>/dev/null)"
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${installed_formulae}" -- "${cur}")
}

__brew_complete_installed_casks() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local installed_casks
  installed_casks="$(command ls "$(brew --caskroom)" 2>/dev/null)"
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${installed_casks}" -- "${cur}")
}

__brew_complete_outdated_formulae() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local outdated_formulae
  outdated_formulae="$(brew outdated --formula --quiet)"
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${outdated_formulae}" -- "${cur}")
}

__brew_complete_outdated_casks() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local outdated_casks
  outdated_casks="$(brew outdated --cask --quiet)"
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${outdated_casks}" -- "${cur}")
}

__brew_complete_tapped() {
  local dir taps taplib
  taplib="$(brew --repository)/Library/Taps"

  for dir in "${taplib}"/*/*
  do
    [[ -d "${dir}" ]] || continue
    dir="${dir#"${taplib}"/}"
    dir="${dir/homebrew-/}"
    taps="${taps} ${dir}"
  done
  __brewcomp "${taps}"
}

__brew_complete_commands() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  local cmds
  HOMEBREW_CACHE=$(brew --cache)
  HOMEBREW_REPOSITORY=$(brew --repo)
  # Do not auto-complete "*instal" or "*uninstal" aliases for "*install" commands.
  if [[ -f "${HOMEBREW_CACHE}/all_commands_list.txt" ]]
  then
    cmds="$(< "${HOMEBREW_CACHE}/all_commands_list.txt" \grep -v instal$)"
  else
    cmds="$(< "${HOMEBREW_REPOSITORY}/completions/internal_commands_list.txt" \grep -v instal$)"
  fi
  while read -r line; do COMPREPLY+=("${line}"); done < <(compgen -W "${cmds}" -- "${cur}")
}

# compopt is only available in newer versions of bash
__brew_complete_files() {
  command -v compopt &> /dev/null && compopt -o default
}

_brew___cache() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --bottle-tag
      --build-from-source
      --cask
      --debug
      --force-bottle
      --formula
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew___caskroom() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_casks
}

_brew___cellar() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew___config() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew___env() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --plain
      --quiet
      --shell
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew___prefix() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --installed
      --quiet
      --unbrewed
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew___repo() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_tapped
}

_brew___repository() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_tapped
}

_brew__s() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --archlinux
      --cask
      --closed
      --debian
      --debug
      --desc
      --fedora
      --fink
      --formula
      --help
      --macports
      --open
      --opensuse
      --pull-request
      --quiet
      --repology
      --ubuntu
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_abv() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --all
      --analytics
      --cask
      --category
      --days
      --debug
      --formula
      --github
      --help
      --installed
      --json
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_analytics() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brewcomp "state on off regenerate-uuid"
}

_brew_audit() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --appcast
      --audit-debug
      --cask
      --debug
      --display-cop-names
      --display-failures-only
      --display-filename
      --except
      --except-cops
      --fix
      --formula
      --git
      --help
      --new
      --no-appcast
      --online
      --only
      --only-cops
      --quiet
      --skip-style
      --strict
      --tap
      --token-conflicts
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_autoremove() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dry-run
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_bottle() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --committer
      --debug
      --force-core-tap
      --help
      --json
      --keep-old
      --merge
      --no-commit
      --no-rebuild
      --only-json-tab
      --quiet
      --root-url
      --root-url-using
      --skip-relocation
      --verbose
      --write
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
  __brew_complete_files
}

_brew_bump() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --full-name
      --help
      --limit
      --no-pull-requests
      --quiet
      --start-with
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_bump_cask_pr() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --commit
      --debug
      --dry-run
      --force
      --fork-org
      --help
      --message
      --no-audit
      --no-browse
      --no-fork
      --no-style
      --online
      --quiet
      --sha256
      --url
      --verbose
      --version
      --write-only
      "
      return
      ;;
    *)
  esac
  __brew_complete_casks
}

_brew_bump_formula_pr() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --commit
      --debug
      --dry-run
      --force
      --fork-org
      --help
      --message
      --mirror
      --no-audit
      --no-browse
      --no-fork
      --online
      --quiet
      --revision
      --sha256
      --strict
      --tag
      --url
      --verbose
      --version
      --write-only
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_bump_revision() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dry-run
      --help
      --message
      --quiet
      --verbose
      --write-only
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_bump_unversioned_casks() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dry-run
      --help
      --limit
      --quiet
      --state-file
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_casks
  __brew_complete_tapped
}

_brew_cat() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_cleanup() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dry-run
      --help
      --prune
      --prune-prefix
      --quiet
      --verbose
      -s
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_command() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_commands
}

_brew_commands() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --include-aliases
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brewcomp "state link unlink"
}

_brew_config() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_create() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --autotools
      --cask
      --cmake
      --crystal
      --debug
      --force
      --go
      --help
      --meson
      --no-fetch
      --node
      --perl
      --python
      --quiet
      --ruby
      --rust
      --set-license
      --set-name
      --set-version
      --tap
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_deps() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --1
      --all
      --annotate
      --cask
      --debug
      --for-each
      --formula
      --full-name
      --help
      --include-build
      --include-optional
      --include-requirements
      --include-test
      --installed
      --quiet
      --skip-recommended
      --tree
      --union
      --verbose
      -n
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_desc() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --description
      --help
      --name
      --quiet
      --search
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_developer() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brewcomp "state on off"
}

_brew_dispatch_build_bottle() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --issue
      --linux
      --linux-self-hosted
      --linux-wheezy
      --macos
      --quiet
      --tap
      --timeout
      --upload
      --verbose
      --workflow
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_doctor() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --audit-debug
      --debug
      --help
      --list-checks
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brewcomp "$(brew doctor --list-checks)"
}

_brew_dr() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --audit-debug
      --debug
      --help
      --list-checks
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brewcomp "$(brew doctor --list-checks)"
}

_brew_edit() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --help
      --print-path
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_environment() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --plain
      --quiet
      --shell
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_extract() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --force
      --help
      --quiet
      --verbose
      --version
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_tapped
}

_brew_fetch() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --bottle-tag
      --build-bottle
      --build-from-source
      --cask
      --debug
      --deps
      --force
      --force-bottle
      --formula
      --help
      --no-quarantine
      --quarantine
      --quiet
      --retry
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_formula() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_generate_man_completions() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --fail-if-not-changed
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_gist_logs() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --new-issue
      --private
      --quiet
      --verbose
      --with-hostname
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_home() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_homepage() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_info() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --all
      --analytics
      --cask
      --category
      --days
      --debug
      --formula
      --github
      --help
      --installed
      --json
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_instal() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --appdir
      --audio-unit-plugindir
      --binaries
      --bottle-arch
      --build-bottle
      --build-from-source
      --cask
      --cc
      --colorpickerdir
      --debug
      --dictionarydir
      --display-times
      --env
      --fetch-HEAD
      --fontdir
      --force
      --force-bottle
      --formula
      --git
      --help
      --ignore-dependencies
      --include-test
      --input-methoddir
      --interactive
      --internet-plugindir
      --keep-tmp
      --language
      --mdimporterdir
      --no-binaries
      --no-quarantine
      --only-dependencies
      --prefpanedir
      --qlplugindir
      --quarantine
      --quiet
      --require-sha
      --screen-saverdir
      --servicedir
      --skip-cask-deps
      --verbose
      --vst-plugindir
      --vst3-plugindir
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_install() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --appdir
      --audio-unit-plugindir
      --binaries
      --bottle-arch
      --build-bottle
      --build-from-source
      --cask
      --cc
      --colorpickerdir
      --debug
      --dictionarydir
      --display-times
      --env
      --fetch-HEAD
      --fontdir
      --force
      --force-bottle
      --formula
      --git
      --help
      --ignore-dependencies
      --include-test
      --input-methoddir
      --interactive
      --internet-plugindir
      --keep-tmp
      --language
      --mdimporterdir
      --no-binaries
      --no-quarantine
      --only-dependencies
      --prefpanedir
      --qlplugindir
      --quarantine
      --quiet
      --require-sha
      --screen-saverdir
      --servicedir
      --skip-cask-deps
      --verbose
      --vst-plugindir
      --vst3-plugindir
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_install_bundler_gems() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --groups
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_irb() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --examples
      --help
      --pry
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_lc() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --all
      --cask
      --debug
      --formula
      --full-name
      --help
      --installed
      --json
      --newer-only
      --quiet
      --tap
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_leaves() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --installed-as-dependency
      --installed-on-request
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_link() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --debug
      --dry-run
      --force
      --help
      --overwrite
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_linkage() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cached
      --debug
      --help
      --quiet
      --reverse
      --test
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_list() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --full-name
      --help
      --multiple
      --pinned
      --quiet
      --verbose
      --versions
      -1
      -l
      -r
      -t
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
  __brew_complete_installed_casks
}

_brew_livecheck() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --all
      --cask
      --debug
      --formula
      --full-name
      --help
      --installed
      --json
      --newer-only
      --quiet
      --tap
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_ln() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --debug
      --dry-run
      --force
      --help
      --overwrite
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_log() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --help
      --max-count
      --oneline
      --patch
      --quiet
      --stat
      --verbose
      -1
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_ls() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --full-name
      --help
      --multiple
      --pinned
      --quiet
      --verbose
      --versions
      -1
      -l
      -r
      -t
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
  __brew_complete_installed_casks
}

_brew_migrate() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dry-run
      --force
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_missing() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --hide
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_options() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --all
      --command
      --compact
      --debug
      --help
      --installed
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_outdated() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --fetch-HEAD
      --formula
      --greedy
      --greedy-auto-updates
      --greedy-latest
      --help
      --json
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_pin() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_postinstall() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_pr_automerge() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --autosquash
      --debug
      --help
      --ignore-failures
      --no-autosquash
      --publish
      --quiet
      --tap
      --verbose
      --with-label
      --without-approval
      --without-labels
      "
      return
      ;;
    *)
  esac
}

_brew_pr_publish() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --autosquash
      --branch
      --debug
      --help
      --message
      --no-autosquash
      --quiet
      --tap
      --verbose
      --workflow
      "
      return
      ;;
    *)
  esac
}

_brew_pr_pull() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --artifact
      --autosquash
      --branch-okay
      --clean
      --committer
      --debug
      --dry-run
      --help
      --ignore-missing-artifacts
      --keep-old
      --message
      --no-commit
      --no-upload
      --quiet
      --resolve
      --root-url
      --root-url-using
      --tap
      --verbose
      --warn-on-upload-failure
      --workflows
      "
      return
      ;;
    *)
  esac
}

_brew_pr_upload() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --committer
      --debug
      --dry-run
      --github-org
      --help
      --keep-old
      --no-commit
      --quiet
      --root-url
      --root-url-using
      --upload-only
      --verbose
      --warn-on-upload-failure
      "
      return
      ;;
    *)
  esac
}

_brew_prof() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --stackprof
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_commands
}

_brew_readall() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --aliases
      --debug
      --help
      --quiet
      --syntax
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_tapped
}

_brew_reinstall() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --appdir
      --audio-unit-plugindir
      --binaries
      --build-from-source
      --cask
      --colorpickerdir
      --debug
      --dictionarydir
      --display-times
      --fontdir
      --force
      --force-bottle
      --formula
      --git
      --help
      --input-methoddir
      --interactive
      --internet-plugindir
      --keep-tmp
      --language
      --mdimporterdir
      --no-binaries
      --no-quarantine
      --prefpanedir
      --qlplugindir
      --quarantine
      --quiet
      --require-sha
      --screen-saverdir
      --servicedir
      --skip-cask-deps
      --verbose
      --vst-plugindir
      --vst3-plugindir
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_release() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --major
      --minor
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_remove() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --force
      --formula
      --help
      --ignore-dependencies
      --quiet
      --verbose
      --zap
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
  __brew_complete_installed_casks
}

_brew_rm() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --force
      --formula
      --help
      --ignore-dependencies
      --quiet
      --verbose
      --zap
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
  __brew_complete_installed_casks
}

_brew_ruby() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      -e
      -r
      "
      return
      ;;
    *)
  esac
  __brew_complete_files
}

_brew_search() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --archlinux
      --cask
      --closed
      --debian
      --debug
      --desc
      --fedora
      --fink
      --formula
      --help
      --macports
      --open
      --opensuse
      --pull-request
      --quiet
      --repology
      --ubuntu
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_sh() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cmd
      --debug
      --env
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_files
}

_brew_sponsors() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_style() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --display-cop-names
      --except-cops
      --fix
      --formula
      --help
      --only-cops
      --quiet
      --reset-cache
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_files
  __brew_complete_tapped
  __brew_complete_formulae
  __brew_complete_casks
}

_brew_tap() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --custom-remote
      --debug
      --force-auto-update
      --full
      --help
      --list-pinned
      --quiet
      --repair
      --shallow
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_tapped
}

_brew_tap_info() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --installed
      --json
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_tapped
}

_brew_tap_new() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --branch
      --debug
      --help
      --no-git
      --pull-label
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_tapped
}

_brew_tc() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dir
      --fail-if-not-changed
      --file
      --fix
      --help
      --ignore
      --quiet
      --suggest-typed
      --update
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_test() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --HEAD
      --debug
      --force
      --help
      --keep-tmp
      --quiet
      --retry
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_tests() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --byebug
      --coverage
      --debug
      --generic
      --help
      --no-compat
      --online
      --only
      --quiet
      --seed
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_typecheck() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dir
      --fail-if-not-changed
      --file
      --fix
      --help
      --ignore
      --quiet
      --suggest-typed
      --update
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_unbottled() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dependents
      --help
      --quiet
      --tag
      --total
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_uninstal() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --force
      --formula
      --help
      --ignore-dependencies
      --quiet
      --verbose
      --zap
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
  __brew_complete_installed_casks
}

_brew_uninstall() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --force
      --formula
      --help
      --ignore-dependencies
      --quiet
      --verbose
      --zap
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
  __brew_complete_installed_casks
}

_brew_unlink() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --dry-run
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_unpack() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --destdir
      --force
      --git
      --help
      --patch
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_unpin() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_installed_formulae
}

_brew_untap() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --force
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_tapped
}

_brew_up() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --force
      --help
      --merge
      --preinstall
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_update() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --force
      --help
      --merge
      --preinstall
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_update_license_data() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --fail-if-not-changed
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_update_maintainers() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_update_python_resources() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --exclude-packages
      --extra-packages
      --help
      --ignore-non-pypi-packages
      --package-name
      --print-only
      --quiet
      --silent
      --verbose
      --version
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_update_report() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --force
      --help
      --preinstall
      --quiet
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_update_test() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --before
      --commit
      --debug
      --help
      --keep-tmp
      --quiet
      --to-tag
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew_upgrade() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --appdir
      --audio-unit-plugindir
      --binaries
      --build-from-source
      --cask
      --colorpickerdir
      --debug
      --dictionarydir
      --display-times
      --dry-run
      --fetch-HEAD
      --fontdir
      --force
      --force-bottle
      --formula
      --greedy
      --greedy-auto-updates
      --greedy-latest
      --help
      --ignore-pinned
      --input-methoddir
      --interactive
      --internet-plugindir
      --keep-tmp
      --language
      --mdimporterdir
      --no-binaries
      --no-quarantine
      --prefpanedir
      --qlplugindir
      --quarantine
      --quiet
      --require-sha
      --screen-saverdir
      --servicedir
      --skip-cask-deps
      --verbose
      --vst-plugindir
      --vst3-plugindir
      "
      return
      ;;
    *)
  esac
  __brew_complete_outdated_formulae
  __brew_complete_outdated_casks
}

_brew_uses() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --cask
      --debug
      --formula
      --help
      --include-build
      --include-optional
      --include-test
      --installed
      --quiet
      --recursive
      --skip-recommended
      --verbose
      "
      return
      ;;
    *)
  esac
  __brew_complete_formulae
}

_brew_vendor_gems() {
  local cur="${COMP_WORDS[COMP_CWORD]}"
  case "${cur}" in
    -*)
      __brewcomp "
      --debug
      --help
      --quiet
      --update
      --verbose
      "
      return
      ;;
    *)
  esac
}

_brew() {
  local i=1 cmd

  # find the subcommand
  while [[ "${i}" -lt "${COMP_CWORD}" ]]
  do
    local s="${COMP_WORDS[i]}"
    case "${s}" in
      --*)
        cmd="${s}"
        break
        ;;
      -*)
        ;;
      *)
        cmd="${s}"
        break
        ;;
    esac
    (( i++ ))
  done

  if [[ "${i}" -eq "${COMP_CWORD}" ]]
  then
    __brew_complete_commands
    return
  fi

  # subcommands have their own completion functions
  case "${cmd}" in
    --cache) _brew___cache ;;
    --caskroom) _brew___caskroom ;;
    --cellar) _brew___cellar ;;
    --config) _brew___config ;;
    --env) _brew___env ;;
    --prefix) _brew___prefix ;;
    --repo) _brew___repo ;;
    --repository) _brew___repository ;;
    -S) _brew__s ;;
    abv) _brew_abv ;;
    analytics) _brew_analytics ;;
    audit) _brew_audit ;;
    autoremove) _brew_autoremove ;;
    bottle) _brew_bottle ;;
    bump) _brew_bump ;;
    bump-cask-pr) _brew_bump_cask_pr ;;
    bump-formula-pr) _brew_bump_formula_pr ;;
    bump-revision) _brew_bump_revision ;;
    bump-unversioned-casks) _brew_bump_unversioned_casks ;;
    cat) _brew_cat ;;
    cleanup) _brew_cleanup ;;
    command) _brew_command ;;
    commands) _brew_commands ;;
    completions) _brew_completions ;;
    config) _brew_config ;;
    create) _brew_create ;;
    deps) _brew_deps ;;
    desc) _brew_desc ;;
    developer) _brew_developer ;;
    dispatch-build-bottle) _brew_dispatch_build_bottle ;;
    doctor) _brew_doctor ;;
    dr) _brew_dr ;;
    edit) _brew_edit ;;
    environment) _brew_environment ;;
    extract) _brew_extract ;;
    fetch) _brew_fetch ;;
    formula) _brew_formula ;;
    generate-man-completions) _brew_generate_man_completions ;;
    gist-logs) _brew_gist_logs ;;
    home) _brew_home ;;
    homepage) _brew_homepage ;;
    info) _brew_info ;;
    instal) _brew_instal ;;
    install) _brew_install ;;
    install-bundler-gems) _brew_install_bundler_gems ;;
    irb) _brew_irb ;;
    lc) _brew_lc ;;
    leaves) _brew_leaves ;;
    link) _brew_link ;;
    linkage) _brew_linkage ;;
    list) _brew_list ;;
    livecheck) _brew_livecheck ;;
    ln) _brew_ln ;;
    log) _brew_log ;;
    ls) _brew_ls ;;
    migrate) _brew_migrate ;;
    missing) _brew_missing ;;
    options) _brew_options ;;
    outdated) _brew_outdated ;;
    pin) _brew_pin ;;
    postinstall) _brew_postinstall ;;
    pr-automerge) _brew_pr_automerge ;;
    pr-publish) _brew_pr_publish ;;
    pr-pull) _brew_pr_pull ;;
    pr-upload) _brew_pr_upload ;;
    prof) _brew_prof ;;
    readall) _brew_readall ;;
    reinstall) _brew_reinstall ;;
    release) _brew_release ;;
    remove) _brew_remove ;;
    rm) _brew_rm ;;
    ruby) _brew_ruby ;;
    search) _brew_search ;;
    sh) _brew_sh ;;
    sponsors) _brew_sponsors ;;
    style) _brew_style ;;
    tap) _brew_tap ;;
    tap-info) _brew_tap_info ;;
    tap-new) _brew_tap_new ;;
    tc) _brew_tc ;;
    test) _brew_test ;;
    tests) _brew_tests ;;
    typecheck) _brew_typecheck ;;
    unbottled) _brew_unbottled ;;
    uninstal) _brew_uninstal ;;
    uninstall) _brew_uninstall ;;
    unlink) _brew_unlink ;;
    unpack) _brew_unpack ;;
    unpin) _brew_unpin ;;
    untap) _brew_untap ;;
    up) _brew_up ;;
    update) _brew_update ;;
    update-license-data) _brew_update_license_data ;;
    update-maintainers) _brew_update_maintainers ;;
    update-python-resources) _brew_update_python_resources ;;
    update-report) _brew_update_report ;;
    update-test) _brew_update_test ;;
    upgrade) _brew_upgrade ;;
    uses) _brew_uses ;;
    vendor-gems) _brew_vendor_gems ;;
    *) ;;
  esac
}

# keep around for compatibility
_brew_to_completion() {
  _brew
}

complete -o bashdefault -o default -F _brew brew
