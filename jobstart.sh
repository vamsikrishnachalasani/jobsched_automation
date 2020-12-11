<job order="yes"
     stop_on_error="no"
     title="job1">
    <script language="shell">
        <![CDATA[
echo %SCHEDULER_PARAM_SCRIPT2EXECUTE%
%SCHEDULER_PARAM_SCRIPT2EXECUTE%
        ]]>
    </script>
    <run_time/>
</job>
