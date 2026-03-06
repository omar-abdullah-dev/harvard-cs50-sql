SELECT friends.friend_id FROM friends
WHERE user_id =(
    SELECT id FROM users
              WHERE username= 'lovelytrust487'
    )
INTERSECT
SELECT friends.friend_id FROM friends
WHERE user_id = (
    SELECT id FROM users
              WHERE username ='lovelytrust487'
    );