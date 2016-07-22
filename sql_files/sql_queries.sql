select * from quotes 
left join users
on quotes.users_user_id = users.user_id;

SELECT * FROM quotes WHERE users_user_id=1;

SELECT favourites.users_user_id, favourites.quotes_quote_id, quotes.quote_id, quotes.quoted_by, quotes.quote_text, quotes.users_user_id, quotes.created_at, quotes.updated_at, users.user_id, users.first_name, users.last_name
FROM favourites
LEFT JOIN quotes
ON quotes_quote_id = quote_id
LEFT JOIN users
ON quotes.users_user_id = users.user_id
WHERE favourites.users_user_id = 2;

SELECT quotes.quote_id, quotes.quoted_by, quotes.quote_text, quotes.users_user_id, quotes.created_at, quotes.updated_at, users.user_id, users.first_name, users.last_name 
FROM quotes 
LEFT JOIN users
ON quotes.users_user_id = users.user_id
WHERE quotes.quote_id NOT IN
(SELECT quotes_quote_id FROM favourites
WHERE favourites.users_user_id = 3)
ORDER BY created_at DESC;






SELECT quotes.quote_id, quotes.quoted_by, quotes.quote_text, quotes.users_user_id, quotes.created_at, quotes.updated_at, users.user_id, users.first_name, users.last_name 
FROM quotes 
LEFT JOIN users
ON quotes.users_user_id = users.user_id
ORDER BY created_at DESC;
