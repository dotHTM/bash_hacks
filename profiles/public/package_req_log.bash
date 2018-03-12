# package_rew_log.bash


bin_lookups='
brew
cpanm
pip
pip3
gem
npm
bobobobobobob
'

function record_request_and_do(){
    some_bin=$1 && shift
    myBin_PATH=$1 && shift
    myCommand="${myBin_PATH} $*"
    echo "$myCommand    ## `timeiso`" >> ~/.req_${some_bin}.hist.bash
    $($myCommand)
}

for some_bin in $bin_lookups; do
    if [[ -n $some_bin ]]; then
        some_bin_PATH=`which ${some_bin}`
        if [[ -n $some_bin_PATH ]]; then
            alias $some_bin="record_request_and_do $some_bin $some_bin_PATH "
        fi
    fi
done


