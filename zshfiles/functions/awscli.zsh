#=#=#=
# Set aws cli util
#
# ref) https://docs.aws.amazon.com/ja_jp/cli/latest/userguide/cli-configure-completion.html
#=#=

# aws credentials and config
export AWS_SHARED_CREDENTIALS_FILE=$HOME/.aws/credentials
export AWS_CONFIG_FILE=$HOME/.aws/config

# Enable completion
source /usr/local/bin/aws_zsh_completer.sh
