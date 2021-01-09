# =========================================================================== #
# Serverless Framework
# =========================================================================== #

# node (nodebrew)
export PATH=$HOME/.nodebrew/current/bin:$PATH
export PATH="$HOME/.yarn/bin:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f $HOME/.nodebrew/node/v12.3.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . $HOME/.nodebrew/node/v12.3.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash

# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f $HOME/.nodebrew/node/v12.3.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . $HOME/.nodebrew/node/v12.3.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[ -f $HOME/.nodebrew/node/v12.3.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash ] && . $HOME/.nodebrew/node/v12.3.1/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.bash
