<?php
include '../mysql.php';
$json = getallheaders();
$credentials = json_decode($json["Data"], true);
$db = new DbConnect();
$query = "SELECT users.username as user, SUM(points) as points_sum, AVG(intensity) as average_intensity, start_time, WEEK(end_time) as week, playgrounds.name
FROM logs 
LEFT JOIN appliances ON appliances.id = logs.appliance_id
LEFT JOIN playgrounds ON playgrounds.id = appliances.playground_id
LEFT JOIN users on users.id = logs.user_id
group by user_id
order by points_sum";

if($credentials["user_id"] != NULL)
{
	$query = "SELECT logs.id, points, intensity, start_time, end_time, playgrounds.name from logs
	left join appliances on appliances.id = logs.appliance_id
	left join playgrounds on playgrounds.id = appliances.playground_id
	where user_id like :user_id";
}

$result = $db->execute_query($query, $credentials, true);
if($result)
	{
		http_response_code(200);
		echo $result;
	}
else
	{
		http_response_code(400);
	}
	
	
?>