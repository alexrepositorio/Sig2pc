<?php
             	unset($_COOKIE['pass']);
				unset($_COOKIE['user']);
				unset($_COOKIE['acceso']);
				setcookie('pass', null, -1, '/');
				setcookie('user', null, -1, '/');
				setcookie('acceso', null, -1, '/');
        		header('Location: login.php');
?>
