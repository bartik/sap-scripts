#!/bin/bash
# ARG_OPTIONAL_SINGLE([host],[h],[Hostname. (Default: hostname command result.)])
# ARG_OPTIONAL_SINGLE([dir],[r],[Directory with hostagent executables.],[/usr/sap/hostctrl/exe/])
# ARG_OPTIONAL_SINGLE([share],[s],[SAP shared directory.],[/export/SAP/software/saphostagent/])
# ARG_OPTIONAL_SINGLE([delay],[y],[Autoupgrade delay in minutes.],[5])
# ARG_OPTIONAL_BOOLEAN([overwrite],[o],[Overwrite existing.],[off])
# ARG_OPTIONAL_SINGLE([pse],[e],[PSE full path.])
# ARG_OPTIONAL_SINGLE([tmp],[t],[Temporary directory.],[/tmp/])
# ARG_OPTIONAL_SINGLE([subject],[j],[Certificate subject],[/C=DE/ST=Baden-Wuerttemberg/L=Beimerstetten/O=GCMA/OU=SCUBA/CN=SAP services])
# ARG_OPTIONAL_SINGLE([user],[u],[Username.])
# ARG_OPTIONAL_SINGLE([pass],[p],[Password.])
# ARG_OPTIONAL_SINGLE([ip],[i],[Listen IP adress of saphostagent.])
# ARG_OPTIONAL_SINGLE([rfile],[m],[Root certificate filename withoud path and extension.],[rootCA])
# ARG_OPTIONAL_SINGLE([cfile],[n],[Client certificate filename withoud path and extension.],[monitoringCA])
# ARG_OPTIONAL_SINGLE([uid],[d],[User ID of user sapadm if different from the one on shared storage], [11114])
# ARG_OPTIONAL_SINGLE([gid],[g],[Group ID of group sapsys if different from the one on shared storage], [11110])
# ARG_OPTIONAL_SINGLE([validity],[a],[Validity of the generated certificate in days.], [365])
# ARG_HELP([Configure autoupdate parameters for hostagent.],[Configure autoupdate parameters for hostagent.],[?],[])
# ARG_POSITIONAL_INF([function],[Function to execute with regard to sso.(root/server/client)],[1])
# ARG_VERSION_AUTO([1.0])

export PS4='+(\D{%D %T} ${BASH_SOURCE}:${LINENO}): ${FUNCNAME[0]:+${FUNCNAME[0]}(): }'
set -euxo pipefail

### START OF CODE GENERATED BY Argbash v2.9.0 one line above ###
# Argbash is a bash code generator used to get arguments parsing right.
# Argbash is FREE SOFTWARE, see https://argbash.io for more info
# Generated online by https://argbash.io/generate

die() {
  local _ret="${2:-1}"
  test "${_PRINT_HELP:-no}" = yes && print_help >&2
  echo "$1" >&2
  exit "${_ret}"
}

begins_with_short_option() {
  local first_option all_short_options='hrsyetjupifdga?v'
  first_option="${1:0:1}"
  test "$all_short_options" = "${all_short_options/$first_option/}" && return 1 || return 0
}

# THE DEFAULTS INITIALIZATION - POSITIONALS
_positionals=()
_arg_function=('')
# THE DEFAULTS INITIALIZATION - OPTIONALS
_arg_host="$(hostname)"
_arg_dir="/usr/sap/hostctrl/exe/"
_arg_share="/export/SAP/software/saphostagent/skript/"
_arg_delay=5
_arg_pse=
_arg_tmp="/tmp/"
_arg_subject=
_arg_user="sapadm"
_arg_pass="OSsolman72"
_arg_ip=$(awk -v h="${_arg_host}" '$0 ~ h && /svc|service/ { print $1 }' /etc/hosts)
_arg_rfile="rootCA"
_arg_cfile="monitoringCA"
_arg_uid=11114
_arg_gid=11110
_arg_validity=365
_arg_overwrite="off"
m_flag_ssl=0
m_flag_ip=0
m_flag_admin=0
m_uid_root="root"
m_entry_ssl="saphostagent/ssl_setup = true"
m_entry_ip="service/http/hostname = "
m_entry_admin="service/sso_admin_user_0 = "

print_help() {
  printf '%s\n' "Configure SSO parameters for hostagent."
  printf 'Usage: %s [-h|--host <arg>] [-r|--dir <arg>] [-s|--share <arg>] [-y|--delay <arg>] [-e|--pse <arg>] [-t|--tmp <arg>] [-j|--subject <arg>] [-u|--user <arg>] [-p|--pass <arg>] [-i|--ip <arg>] [-m|--rfile <arg>] [-n|--cfile <arg>] [-d|--uid <arg>] [-g|--gid <arg>] [-a|--validity <arg>] [-?|--help] [-v|--version] <function-1> [<function-2>] ... [<function-n>] ...\n' "$0"
  printf '\t%s\n' "<function>: Function to execute with regard to sso. (root/server/client)"
  printf '\t%s\n' "-h, --host: Hostname. (Default: hostname command result.) (no default)"
  printf '\t%s\n' "-r, --dir: Directory with hostagent executables. (default: '/usr/sap/hostctrl/exe/')"
  printf '\t%s\n' "-s, --share: SAP shared directory. (default: '/export/SAP/software/saphostagent/')"
  printf '\t%s\n' "-y, --delay: Autoupgrade delay in minutes. (default: '5')"
  printf '\t%s\n' "-e, --pse: PSE full path. (no default)"
  printf '\t%s\n' "-t, --tmp: Temporary directory. (default: '/tmp/')"
  printf '\t%s\n' "-j, --subject: Certificate subject (default: '/C=DE/ST=Baden-Wuerttemberg/L=Beimerstetten/O=GCMA/OU=SCUBA/CN=SAP services')"
  printf '\t%s\n' "-o, --overwrite, --no-overwrite: Overwrite existing. (off by default)"
  printf '\t%s\n' "-u, --user: Username. (no default)"
  printf '\t%s\n' "-p, --pass: Password. (no default)"
  printf '\t%s\n' "-i, --ip: Listen IP adress of saphostagent. (no default)"
  printf '\t%s\n' "-m, --rfile: Root certificate filename withoud path and extension. (default: 'rootCA')"
  printf '\t%s\n' "-n, --cfile: Client certificate filename withoud path and extension. (default: 'monitoringCA')"
  printf '\t%s\n' "-d, --uid: User ID of user sapadm if different from the one on shared storage (default: '11114')"
  printf '\t%s\n' "-g, --gid: Group ID of group sapsys if different from the one on shared storage (default: '11110')"
  printf '\t%s\n' "-a, --validity: Validity of the generated certificate in days. (default: '365')"
  printf '\t%s\n' "-?, --help: Prints help"
  printf '\t%s\n' "-v, --version: Prints version"
  printf '\n%s\n' "Configure SSO parameters for hostagent."
}

parse_commandline() {
  _positionals_count=0
  while test $# -gt 0; do
    _key="$1"
    case "$_key" in
    -h | --host)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_host="$2"
      shift
      ;;
    --host=*)
      _arg_host="${_key##--host=}"
      ;;
    -h*)
      _arg_host="${_key##-h}"
      ;;
    -r | --dir)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_dir="$2"
      shift
      ;;
    --dir=*)
      _arg_dir="${_key##--dir=}"
      ;;
    -r*)
      _arg_dir="${_key##-r}"
      ;;
    -s | --share)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_share="$2"
      shift
      ;;
    --share=*)
      _arg_share="${_key##--share=}"
      ;;
    -s*)
      _arg_share="${_key##-s}"
      ;;
    -y | --delay)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_delay="$2"
      shift
      ;;
    --delay=*)
      _arg_delay="${_key##--delay=}"
      ;;
    -y*)
      _arg_delay="${_key##-y}"
      ;;
    -e | --pse)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_pse="$2"
      shift
      ;;
    --pse=*)
      _arg_pse="${_key##--pse=}"
      ;;
    -e*)
      _arg_pse="${_key##-e}"
      ;;
    -t | --tmp)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_tmp="$2"
      shift
      ;;
    --tmp=*)
      _arg_tmp="${_key##--tmp=}"
      ;;
    -t*)
      _arg_tmp="${_key##-t}"
      ;;
    -j | --subject)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_subject="$2"
      shift
      ;;
    --subject=*)
      _arg_subject="${_key##--subject=}"
      ;;
    -j*)
      _arg_subject="${_key##-j}"
      ;;
    -o | --no-overwrite | --overwrite)
      _arg_overwrite="on"
      test "${1:0:5}" = "--no-" && _arg_overwrite="off"
      ;;
    -o*)
      _arg_overwrite="on"
      _next="${_key##-o}"
      if test -n "$_next" -a "$_next" != "$_key"; then
        { begins_with_short_option "$_next" && shift && set -- "-o" "-${_next}" "$@"; } || die "The short option '$_key' can't be decomposed to ${_key:0:2} and -${_key:2}, because ${_key:0:2} doesn't accept value and '-${_key:2:1}' doesn't correspond to a short option."
      fi
      ;;
    -u | --user)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_user="$2"
      shift
      ;;
    --user=*)
      _arg_user="${_key##--user=}"
      ;;
    -u*)
      _arg_user="${_key##-u}"
      ;;
    -p | --pass)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_pass="$2"
      shift
      ;;
    --pass=*)
      _arg_pass="${_key##--pass=}"
      ;;
    -p*)
      _arg_pass="${_key##-p}"
      ;;
    -i | --ip)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_ip="$2"
      shift
      ;;
    --ip=*)
      _arg_ip="${_key##--ip=}"
      ;;
    -i*)
      _arg_ip="${_key##-i}"
      ;;
    -m | --rfile)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_rfile="$2"
      shift
      ;;
    --rfile=*)
      _arg_rfile="${_key##--rfile=}"
      ;;
    -m*)
      _arg_rfile="${_key##-m}"
      ;;
    -n | --cfile)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_cfile="$2"
      shift
      ;;
    --cfile=*)
      _arg_cfile="${_key##--cfile=}"
      ;;
    -n*)
      _arg_cfile="${_key##-n}"
      ;;
    -d | --uid)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_uid="$2"
      shift
      ;;
    --uid=*)
      _arg_uid="${_key##--uid=}"
      ;;
    -d*)
      _arg_uid="${_key##-d}"
      ;;
    -g | --gid)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_gid="$2"
      shift
      ;;
    --gid=*)
      _arg_gid="${_key##--gid=}"
      ;;
    -g*)
      _arg_gid="${_key##-g}"
      ;;
    -a | --validity)
      test $# -lt 2 && die "Missing value for the optional argument '$_key'." 1
      _arg_validity="$2"
      shift
      ;;
    --validity=*)
      _arg_validity="${_key##--validity=}"
      ;;
    -a*)
      _arg_validity="${_key##-a}"
      ;;
    -\? | --help)
      print_help
      exit 0
      ;;
    -\?*)
      print_help
      exit 0
      ;;
    -v | --version)
      printf '%s %s\n\n%s\n' "" "1.0" 'Configure autoupdate parameters for hostagent.'
      exit 0
      ;;
    -v*)
      printf '%s %s\n\n%s\n' "" "1.0" 'Configure autoupdate parameters for hostagent.'
      exit 0
      ;;
    *)
      _last_positional="$1"
      _positionals+=("$_last_positional")
      _positionals_count=$((_positionals_count + 1))
      ;;
    esac
    shift
  done
}

handle_passed_args_count() {
  local _required_args_string="'function'"
  test "${_positionals_count}" -ge 1 || _PRINT_HELP=yes die "FATAL ERROR: Not enough positional arguments - we require at least 1 (namely: $_required_args_string), but got only ${_positionals_count}." 1
}

assign_positional_args() {
  local _positional_name _shift_for=$1
  _positional_names="_arg_function "
  _our_args=$((${#_positionals[@]} - 1))
  for ((ii = 0; ii < _our_args; ii++)); do
    _positional_names="$_positional_names _arg_function[$((ii + 1))]"
  done

  shift "$_shift_for"
  for _positional_name in ${_positional_names}; do
    test $# -gt 0 || break
    eval "$_positional_name=\${1}" || die "Error during argument parsing, possibly an Argbash bug." 1
    shift
  done
}

parse_commandline "$@"
handle_passed_args_count
assign_positional_args 1 "${_positionals[@]}"

# OTHER STUFF GENERATED BY Argbash

### END OF CODE GENERATED BY Argbash (sortof) ### ])

export LD_LIBRARY_PATH="${_arg_dir}"
export SECUDIR="${_arg_dir}sec"
m_profile="${_arg_dir}host_profile"
m_pse_server="${SECUDIR}/SAPSSLS.pse"
m_pse_client="${SECUDIR}/SAPSSLC.pse"
m_exe_openssl="openssl"
m_exe_sapgenpse="${_arg_dir}sapgenpse"
#m_p10=$(find ${SECUDIR} -type f -regex ".*${_arg_host}.*\.p10"|head -1)

createPSE()
{
  # Parameter
  m_pse=$1
  m_csrt=$2
  m_cn=$3

  if [[ -f ${m_pse} && ${_arg_overwrite} != "on" ]]; then
    # PSE exists generate csr only
    "${m_exe_sapgenpse}" gen_pse -p "${m_pse}" \
    -onlyreq \
    -j \
    -r "${_arg_share}${m_csrt}.csr" \
    -k "GN-dNSName:${_arg_host}" \
    -k "GN-dNSName:localhost" \
    -k "GN-iPAddress:${_arg_ip}" \
    -k "GN-iPAddress:127.0.0.1" \
    -x "${_arg_pass}"
  else
    # Backup old PSE and make new
    mv "${SECUDIR}" "${SECUDIR}.${m_sfx}"
    mkdir -p "${SECUDIR}"
    chown root:sapsys "${SECUDIR}"
    cd "${SECUDIR}" || exit

    # Create PSE
    "${m_exe_sapgenpse}" gen_pse -p "${m_pse}" \
    -k "GN-dNSName:${_arg_host}" \
    -k "GN-dNSName:localhost" \
    -k "GN-iPAddress:${_arg_ip}" \
    -k "GN-iPAddress:127.0.0.1" \
    -r "${_arg_share}${m_csrt}.csr" \
    -x "${_arg_pass}" "${m_cn}"

    # Grant Host Agent access to the PSE
    "${m_exe_sapgenpse}" seclogin -p "${m_pse}" \
    -x "${_arg_pass}" \
    -O "${_arg_user}"

    # Allow file access
    chmod 644 "${m_pse}"
  fi

  # Set ownership on share
  chown -h "${_arg_uid}":"${_arg_gid}" "${_arg_share}${m_csrt}.csr"

  # Verify CSR
  "${m_exe_openssl}" req -in "${_arg_share}${m_csrt}.csr" -noout -text

  # Generate saphostagent cert
  "${m_exe_openssl}" x509 -req \
  -extfile <(printf "subjectAltName=IP:%s,IP:127.0.0.1,DNS:%s,DNS:localhost" "${_arg_ip}" "${_arg_host}") \
  -in "${_arg_share}${m_csrt}.csr" \
  -passin pass:"${_arg_pass}" \
  -CA "${_arg_share}${_arg_rfile}.crt" \
  -CAkey "${_arg_share}${_arg_rfile}.key" \
  -CAcreateserial \
  -out "${_arg_share}${m_csrt}.crt" \
  -days "${_arg_validity}" \
  -sha256

  # verify cert
  "${m_exe_openssl}" x509 -in "${_arg_share}${m_csrt}.crt" -noout -text

  # import to Server PSE
  "${m_exe_sapgenpse}" import_own_cert -p "${m_pse}" \
  -x "${_arg_pass}" \
  -c "${_arg_share}${m_csrt}.crt" \
  -r "${_arg_share}${_arg_rfile}.crt"

  # Verify the chain
  "${m_exe_sapgenpse}" get_my_name -p "${m_pse}" \
  -x "${_arg_pass}" \
  -v
}

if [[ ${_arg_function[0]} == "root" ]]; then

  # default subject for root certificate
  if [[ ${#_arg_subject} -lt 1 ]]; then
    _arg_subject="/C=DE/ST=Baden-Wuerttemberg/L=Beimerstetten/O=GCME/OU=SCUBA/CN=SAP services"
  fi
  "${m_exe_openssl}" genrsa -des3 \
  -passout pass:"${_arg_pass}" \
  -out "${_arg_share}${_arg_rfile}.key" \
  4096
  "${m_exe_openssl}" req -x509 -new -nodes \
  -passin pass:"${_arg_pass}" \
  -subj "${_arg_subject}" \
  -key "${_arg_share}${_arg_rfile}.key" \
  -sha256 -days "${_arg_validity}" \
  -out "${_arg_share}${_arg_rfile}.crt"
elif [[ ${_arg_function[0]} == "server" ]]; then

  # default subject for server certificate
  if [[ ${#_arg_subject} -lt 1 ]]; then
    _arg_subject="CN=${_arg_host}.service.dc"
  fi

  # set unique string
  m_epoch=$(date +"%s")
  m_sfx=$(printf "%X\n" "${m_epoch}")

  # stop the agent
  "${_arg_dir}saphostexec" -stop

  createPSE "${m_pse_server}" "${_arg_host}" "${_arg_subject}"

  # Import monitoring client cert into PSE
  "${m_exe_sapgenpse}" maintain_pk -p "${m_pse}" \
  -x "${_arg_pass}" \
  -a "${_arg_share}${_arg_cfile}.crt"

  # Extract subject from monitoring certificate
  m_cn_client=$("${m_exe_openssl}" x509 -in "${_arg_share}${_arg_cfile}.crt" -noout -subject)
  m_cn_client=${m_cn_client#*/}
  m_cn_client=${m_cn_client//\//,}

  # Configure settings
  while IFS= read -r m_line; do
    case "${m_line}" in
    saphostagent/ssl_setup*)
      echo "${m_entry_ssl}"
      m_flag_ssl=1
      ;;
    service/http/hostname*)
      echo "${m_entry_ip}${_arg_ip}"
      m_flag_ip=1
      ;;
    service/sso_admin_user_0*)
      echo "${m_entry_admin}${m_cn_client}"
      m_flag_admin=1
      ;;
    *)
      echo "${m_line}"
      ;;
    esac
  done <"${m_profile}" >"${_arg_tmp}host_profile.${m_sfx}"

  {
    if [[ ${m_flag_ssl} == 0 ]]; then
      echo "${m_entry_ssl}"
    fi
    if [[ ${m_flag_ip} == 0 ]]; then
      echo "${m_entry_ip}${_arg_ip}"
    fi
    if [[ ${m_flag_admin} == 0 ]]; then
      echo "${m_entry_admin}${m_cn_client}"
    fi
  } >>"${_arg_tmp}host_profile.${m_sfx}"

  # switch configuration
  mv "${m_profile}" "${_arg_tmp}"
  mv "${_arg_tmp}host_profile.${m_sfx}" "${m_profile}"
  chown -h "${m_uid_root}":"${_arg_gid}" "${m_profile}"

  # Restart Host Agent
  "${_arg_dir}saphostexec" -restart pf="${m_profile}"
elif [[ ${_arg_function[0]} == "client" ]]; then

  # default subject for server certificate
  if [[ ${#_arg_subject} -lt 1 ]]; then
    _arg_subject="CN=monitoring"
  fi

  # set unique string
  m_epoch=$(date +"%s")
  m_sfx=$(printf "%X\n" "${m_epoch}")

  createPSE "${m_pse_client}" "${_arg_cfile}" "${_arg_subject}"
fi
