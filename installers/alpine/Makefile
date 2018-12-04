


default:
	${MAKE} test-local


test-local:
	docker run -ti --rm alpine:latest ash -c "`cat ./alpine.ash`"

test-github:
	docker run -ti --rm alpine:latest ash -c "wget -O - https://raw.githubusercontent.com/dotHTM/bash_hacks/master/profiles/alpine.ash | ash"
