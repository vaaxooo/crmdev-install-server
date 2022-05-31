# deploy

<b>Пароль на работу с GIT:</b> <code>Zoparu33</code>

<h3>Настройка NGINX:</h3>
<code>cd /etc/nginx/sites-enabled</code><br>
(Отредактировать 2-а конфигурационных файла (3-я строка) - server_name api-sub.growgold.xyz; (Отредактирова на нужный поддомен))

<h3>Запуск фронтенда:</h3>
Настроить .env на поддомен бэкенда
npm run build
pm2 serve build 3000 --spa 



<h3>Изменение и получение данных пользователей:</h3>
<code>mysql</code><br>
<code>select id email, role from users;</code><br>
<code>update users set role = 'admin' where id = 1;</code><br>
<code>update users set login = 'Название офиса' where id = 1;</code><br>
<code>update users set role = 'reporting' where id = 3;</code><br>
<code>exit;</code><br>
 
