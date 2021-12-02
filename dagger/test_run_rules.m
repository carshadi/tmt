do_actually_submit = true ;
maximum_running_slot_count = 5 ;
bsub_option_string = '-P scicompsoft -W 59 -J test-run-rules' ;
slots_per_job = 1 ;
stdouterr_file_name = '' ;  % will go to /dev/null
do_use_xvfb = false ;
rule_1 = struct('name_from_input_file_index', {{'file_0.mat'}}, ...
                'name_from_output_file_index', {{'file_1.mat'}}, ...
                'function_handle', { @increment_mat_file }, ...
                'other_arguments', { {'file_1.mat', 'file_0.mat'} }, ...
                'slot_count', {slots_per_job}, ...
                'stdouterr_file_name', {'rule_1.stdouterr.txt'}, ...
                'bsub_option_string', {bsub_option_string}, ...
                'do_use_xvfb', {do_use_xvfb} ) ;
rule_2 = struct('name_from_input_file_index', {{'file_1.mat'}}, ...
                'name_from_output_file_index', {{'file_2.mat'}}, ...
                'function_handle', { @increment_mat_file }, ...
                'other_arguments', { {'file_2.mat', 'file_1.mat'} }, ...
                'slot_count', {slots_per_job}, ...
                'stdouterr_file_name', {'rule_2.stdouterr.txt'}, ...
                'bsub_option_string', {bsub_option_string}, ...
                'do_use_xvfb', {do_use_xvfb} ) ;
rule_from_rule_index = vertcat(rule_1, rule_2) ;            

% Create the initial input file
ensure_file_does_not_exist('file_0.mat') ;
ensure_file_does_not_exist('file_1.mat') ;
ensure_file_does_not_exist('file_2.mat') ;
save_anonymous('file_0.mat', 0) ;                    

maximum_wait_time = 200 ;
do_show_progress_bar = true ;
[is_rule_done_from_rule_index, job_status_from_rule_index] = ...
    run_rules(rule_from_rule_index, maximum_running_slot_count, do_actually_submit, maximum_wait_time, do_show_progress_bar)  %#ok<NOPTS>
