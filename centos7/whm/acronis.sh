#!/bin/sh


{
echo "[DEBUG] Starting ACRONIS installer" >> /var/log/cpanel.process.log

REPO_BASE="https://download.acronis.com/ci/cpanel/stable/acronis-cpanel-stable"

usage()
{
    echo "Usage: $0 [OPTIONS]" >&2
    echo "  -h                   Display this help message" >&2
    echo "  -r PATH              Override base repository path" >&2
}

parse_options()
{
    while getopts ':h:r:' opt; do
        case "$opt" in
            h)
                usage
                exit 0
                ;;
            r)
                REPO_BASE=$OPTARG
                ;;
            :)
                echo "Option -$OPTARG requires an argument" >&2
                usage
                exit 3
                ;;
        esac
    done
}

parse_options "$@"

cat > /etc/yum.repos.d/acronis-cpanel-stable.repo <<EOF
[acronis-cpanel-stable]
name=Acronis Repository for cPanel plugin
baseurl=$REPO_BASE
enabled=1
gpgcheck=0
EOF

yum install -y acronis-backup-cpanel

echo "[DEBUG] Finished ACRONIS installer" >> /var/log/cpanel.process.log

} 2>&1 | tee -a /var/log/cpanel.tools.log