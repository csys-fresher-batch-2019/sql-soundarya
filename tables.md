# Table design for simple social media

## table1

* user_list

| user_id | user_name | email           | age | gender | dob       | created_date                 | status     |
|---------|-----------|-----------------|-----|--------|-----------|------------------------------|------------|
| 1       | soundarya | sound@gmail.com | 21  | female | 28-DEC-98 | 30-DEC-19 11.24.17.955164 PM | i_am_sound |
| 2       | aishu     | aishu@gmail.com | 20  | female | 31-DEC-98 | 30-DEC-19 11.24.17.959820 PM | i_am_ice   |
| 3       | mala      | mala@gmail.com  | 19  | female | 27-MAR-98 | 30-DEC-19 11.24.17.963878 PM | i_am_mala  |


## table 2

* friend_request

| user1_id | user2_id | current_status | action_performed_by |
|----------|----------|----------------|---------------------|
| 1        | 3        | accepted       | 3                   |
| 1        | 2        | blocked        | 1                   |

## table 3

* posts

| post_id | user_id | post_type | caption         | date_created                 | date_updated |
|---------|---------|-----------|-----------------|------------------------------|--------------|
| 201     | 1       | image     | have a nice day | 31-DEC-19 01.19.55.103225 AM |  -           |
| 202     | 2       | video     | happy morning   | 31-DEC-19 01.21.03.888304 AM |  -           |
