# deploy

<b>Пароль на работу с GIT:</b> <code>Zoparu33</code>

<h3>Работа с deploy.sh</h3>
<code>chmod -R 777 deploy</code><br>
<code>cd deploy</code><br>
<code>./deploy.sh</code><br>

<h3>Настройка NGINX:</h3>
<code>cd /etc/nginx/sites-enabled</code><br>
(Отредактировать 2-а конфигурационных файла (3-я строка) - <b>server_name api-sub.growgold.xyz;</b> (Отредактирова на нужный поддомен))<br>
<code>systemctl restart nginx</code><br>

<h3>Запуск фронтенда:</h3>
Настроить .env на поддомен бэкенда и выполнить следующие команды:<br>
<code>npm run build</code><br>
<code>pm2 serve build 3000 --spa</code><br>

<h3>Изменение и получение данных пользователей:</h3>
<code>mysql</code><br>
<code>select id email, role from users;</code><br>
<code>update users set role = 'admin' where id = 1;</code><br>
<code>update users set login = 'Название офиса' where id = 1;</code><br>
<code>update users set role = 'reporting' where id = 3;</code><br>
<code>exit;</code><br>
 
