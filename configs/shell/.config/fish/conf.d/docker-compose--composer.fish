abbr -a dc 'sudo docker-compose'
abbr -a dce 'sudo docker-compose exec'
abbr -a dcu 'sudo docker-compose up -d'
abbr -a dcl 'sudo docker-compose logs'
abbr -a dcs 'sudo docker-compose stop'

function __docker_compose_composer_using_commands
	set -l cmd (commandline -poc)

	if test (count $cmd) -gt (count $argv)
		set -e cmd[1]
		string match -q -- "$argv*" "$cmd"

		return $status
	end
end

complete -f -c docker-compose -n "__docker_compose_composer_using_commands exec"

# Completions for Composer in Docker
set -l composer_commands install update remove require

complete -fc docker-compose -n "__docker_compose_composer_using_commands exec php composer; and \
	not __fish_seen_subcommand_from $commands" -a "$commands"

