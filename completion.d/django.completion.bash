# ./manage.py completion (Django Admin - Django 1.11)

# Django's ./manage.py statically generated autocompletion source code.
# https://github.com/diegolagoglez/django-bash-completion.git -- Diego Lago <diego.lago.gonzalez@gmail.com>
# Generated by generate-completion-variables.py on 2017-06-14 12:02:04 for Django version 1.11.

MANAGE_PY_SUBCOMMANDS="check diffsettings loaddata create_app dumpdata compile_pyc remove_stale_contenttypes inspectdb show_template_tags clean_pyc unreferenced_files clearsessions runprofileserver describe_form createcachetable update_permissions sqlsequencereset show_urls syncdata dumpscript validate_templates delete_squashed_migrations showmigrations set_fake_emails print_user_for_session show_templatetags generate_secret_key create_command passwd sqlflush sqlmigrate runserver flush changepassword startapp graph_models startproject set_default_site drop_test_database mail_debug sqldiff clear_cache sqlcreate testserver squashmigrations runserver_plus collectstatic test findstatic shell create_jobs makemigrations print_settings runjob sqldsn admin_generator shell_plus createsuperuser sendtestemail reset_db compilemessages makemessages pipchecker create_template_tags runscript migrate find_template runjobs dbshell export_emails notes set_fake_passwords"

declare -A MANAGE_PY_SUBCOMMANDS_OPTIONS

MANAGE_PY_SUBCOMMANDS_OPTIONS[check]="--traceback --version --pythonpath -v --deploy app_label --fail-level --list-tags --settings --no-color -h --tag"
MANAGE_PY_SUBCOMMANDS_OPTIONS[diffsettings]="--traceback --version --pythonpath -v --all --settings --no-color -h --default"
MANAGE_PY_SUBCOMMANDS_OPTIONS[loaddata]="--traceback --version --pythonpath -v fixture --database --app --ignorenonexistent --settings --no-color -h -e"
MANAGE_PY_SUBCOMMANDS_OPTIONS[create_app]="--diagram --traceback --version --pythonpath -v --template --parent_path -d --settings --no-color -h APP_NAME"
MANAGE_PY_SUBCOMMANDS_OPTIONS[dumpdata]=" -o --traceback --natural-foreign --pks --format --version --pythonpath -v app_label --natural-primary --database -a -e --settings --no-color -h --indent"
MANAGE_PY_SUBCOMMANDS_OPTIONS[compile_pyc]="--traceback --version --pythonpath -v --path --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[remove_stale_contenttypes]="--traceback --version --pythonpath -v --database --noinput --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[inspectdb]="--traceback --version --pythonpath -v --database --settings --no-color -h table"
MANAGE_PY_SUBCOMMANDS_OPTIONS[show_template_tags]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[clean_pyc]="--traceback --version --pythonpath -v --optimize --path --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[unreferenced_files]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[clearsessions]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[runprofileserver]="--kcachegrind --noreload --traceback --nomedia --version --pythonpath -v --prof-path --prof-file --insecure --nothreading --use-cprofile addrport --settings --no-color -h --nostatic"
MANAGE_PY_SUBCOMMANDS_OPTIONS[describe_form]="--traceback --version --pythonpath -v application --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[createcachetable]="--traceback table_name --version --pythonpath -v --dry-run --database --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[update_permissions]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[sqlsequencereset]="--traceback --version --pythonpath -v app_label --database --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[show_urls]=" --decorator --traceback --language --urlconf --format --version --pythonpath -v --unsorted --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[syncdata]="--skip-remove --traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[dumpscript]="--traceback --version --pythonpath -v appname --settings --no-color -h --autofield"
MANAGE_PY_SUBCOMMANDS_OPTIONS[validate_templates]="--traceback --version --pythonpath -v --break --include --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[delete_squashed_migrations]="--traceback --version --pythonpath -v squashed_migration_name --dry-run --noinput --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[showmigrations]="--traceback --version --pythonpath -v --list app_label --database --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[set_fake_emails]="-s --traceback --exclude-groups --exclude --version --pythonpath -v -a --include --settings --no-color -h --include-groups --email"
MANAGE_PY_SUBCOMMANDS_OPTIONS[print_user_for_session]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[show_templatetags]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[generate_secret_key]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[create_command]="--traceback --version --pythonpath -v --name app_label --dry-run --base --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[passwd]="--traceback --version --pythonpath -v username --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[sqlflush]="--traceback --version --pythonpath -v --database --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[sqlmigrate]="--traceback --version --pythonpath -v --backwards --database --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[runserver]="--noreload --traceback --version --pythonpath -v --ipv --insecure --nothreading addrport --settings --no-color -h --nostatic"
MANAGE_PY_SUBCOMMANDS_OPTIONS[flush]="--traceback --version --pythonpath -v --database --noinput --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[changepassword]="--traceback --version --pythonpath -v username --database --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[startapp]="directory --traceback --version --pythonpath -v --name --template --settings --no-color -h --extension"
MANAGE_PY_SUBCOMMANDS_OPTIONS[graph_models]="--group-models --disable-sort-fields --disable-fields --settings --exclude-models -h --language --version --no-inheritance --all-applications --include-models --pydot --pygraphviz -v app_label --hide-relations-from-fields --output --verbose-names --no-color --traceback --pythonpath --exclude-columns --json --inheritance --layout"
MANAGE_PY_SUBCOMMANDS_OPTIONS[startproject]="directory --traceback --version --pythonpath -v --name --template --settings --no-color -h --extension"
MANAGE_PY_SUBCOMMANDS_OPTIONS[set_default_site]="--system-fqdn --traceback --version --pythonpath -v --name --settings --no-color -h --domain"
MANAGE_PY_SUBCOMMANDS_OPTIONS[drop_test_database]="--traceback -R -P --version --pythonpath -v -D --noinput -U --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[mail_debug]="--traceback --version --pythonpath -v --output --settings --no-color -h --use-settings"
MANAGE_PY_SUBCOMMANDS_OPTIONS[sqldiff]="--output_text --traceback --dense-output --version --pythonpath -v app_label --not-only-existing --include-proxy-models --all-applications --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[clear_cache]="--traceback --version --pythonpath -v --cache --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[sqlcreate]="--traceback -R --version --pythonpath -v -D --router --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[testserver]="--traceback --version --pythonpath -v --ipv fixture --noinput --addrport --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[squashmigrations]="--traceback --version --pythonpath -v start_migration_name --no-optimize --noinput --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[runserver_plus]=" --nopin --nothreading --browser --settings -h --version default --nostatic --cert --ipv -v --output --ipdb --no-color --print-sql --noreload --extra-file --reloader-interval --keep-meta-shutdown --traceback --pythonpath --insecure --threaded addrport --pm --startup-messages --pdb"
MANAGE_PY_SUBCOMMANDS_OPTIONS[collectstatic]="-c --traceback --version --pythonpath -v -l --no-post-process --no-default-ignore --noinput -i --settings --no-color -h -n"
MANAGE_PY_SUBCOMMANDS_OPTIONS[test]="--failfast --traceback -t N --testrunner --version --pythonpath -v --exclude-tag -p --tag --parallel -r -d --noinput test_label --settings --no-color -h --debug-mode -k"
MANAGE_PY_SUBCOMMANDS_OPTIONS[findstatic]="--first --traceback --version --pythonpath -v staticfile --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[shell]="-c --traceback --version --pythonpath -v --no-startup --plain -i --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[create_jobs]="--traceback --version --pythonpath -v app_label --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[makemigrations]="--traceback --version --pythonpath -v app_label --dry-run --check --merge --empty --noinput --settings --no-color -h -n -e"
MANAGE_PY_SUBCOMMANDS_OPTIONS[print_settings]="--traceback --format --version --pythonpath -v --settings --no-color -h --indent"
MANAGE_PY_SUBCOMMANDS_OPTIONS[runjob]="--traceback --version --pythonpath -v --list app_name job_name --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[sqldsn]="-s --traceback -R --version --pythonpath -v --style --router -a -q --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[admin_generator]="-s --traceback --version --pythonpath -v -l -p default -r -d model_name --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[shell_plus]="--connection-file --dont-load --bpython --traceback --use-pythonrc --vi --no-browser --version --pythonpath -v --notebook --ptpython --ptipython --ipython --plain --quiet-load --kernel --settings --no-color --print-sql -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[createsuperuser]="--traceback --username --version --pythonpath -v --database --noinput --settings --no-color -h --email"
MANAGE_PY_SUBCOMMANDS_OPTIONS[sendtestemail]="--traceback --managers --version --pythonpath -v --admins email --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[reset_db]="-c --traceback -R -P --version --pythonpath -v -D -O --noinput --no-utf -U --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[compilemessages]="--traceback --exclude --version --pythonpath -v --use-fuzzy --locale --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[makemessages]="--extension --traceback --no-obsolete --exclude --version --pythonpath -v --keep-pot --all --no-default-ignore --no-wrap --locale --no-location --ignore --settings --no-color -h --symlinks --domain"
MANAGE_PY_SUBCOMMANDS_OPTIONS[pipchecker]="-t --traceback --version --pythonpath -v -r --settings --no-color -h -n"
MANAGE_PY_SUBCOMMANDS_OPTIONS[create_template_tags]="--traceback --version --pythonpath -v --name app_label --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[runscript]="-s --traceback --fixtures SCRIPT_ARGS --script-args --version --pythonpath -v --noscripts --email-exception script --email-notifications --settings --no-color -h --no-traceback"
MANAGE_PY_SUBCOMMANDS_OPTIONS[migrate]="--traceback migration_name --version --pythonpath -v app_label --fake --run-syncdb --database --noinput --settings --no-color -h --fake-initial"
MANAGE_PY_SUBCOMMANDS_OPTIONS[find_template]="--traceback --version --pythonpath -v template --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[runjobs]="--traceback when --version --pythonpath -v --list --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[dbshell]="--traceback --version --pythonpath -v --database --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[export_emails]="--traceback --group --format --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[notes]="--traceback --version --pythonpath -v --settings --no-color -h"
MANAGE_PY_SUBCOMMANDS_OPTIONS[set_fake_passwords]="--traceback --prompt --version --pythonpath -v --settings --no-color -h --password"

function find_applications() {
	local apps=""
	for app in $(ls */__init__.py 2>/dev/null); do
		apps+=" $(dirname $app)"
	done
	echo $apps
}

function find_migrations_names() {
	local app="$1"
	if [ "$app" == "" ]; then
		app='*'
	fi
	local migrations=""
	for migration in $(ls $app/migrations/[0-9]*.py 2>/dev/null); do
		migrations+=" $migration"
	done
	echo $migrations
}

function get_arguments_for_command() {
	local command="$1"
	local app=
	if [ ! -z "$2" -a "$2" != "./manage.py" ]; then  # FIXME: Use a variable to set './manage.py' name.
		command="$2"
		app="$1"
	fi
	if [ ${MANAGE_PY_SUBCOMMANDS_OPTIONS[$command]+isset} ]; then
		local the_list="${MANAGE_PY_SUBCOMMANDS_OPTIONS[$command]}"
		if [ -z "$app" ]; then
			if [[ $the_list =~ app_label ]]; then
				the_list="$(find_applications) $the_list"
			fi
		fi
		the_list=${the_list/app_label/}
		if [[ $the_list =~ migration_name ]]; then
			if [ -z "$app" -a -d "$command" ]; then
				app=$command
			fi
			the_list="$(find_migrations_names $app) $the_list"
		fi
		the_list=${the_list/migration_name/}
		echo $the_list
	else
		echo $MANAGE_PY_SUBCOMMANDS
	fi
}

function django_admin_completion() {
	local cur=${COMP_WORDS[COMP_CWORD]}
	local prev=${COMP_WORDS[COMP_CWORD-1]}
	local prev_prev=${COMP_WORDS[COMP_CWORD-2]}
	COMPREPLY=( $(compgen -W "$(get_arguments_for_command ${prev} ${prev_prev})" -- ${cur}) )
}

complete -F django_admin_completion ./manage.py manage.py
