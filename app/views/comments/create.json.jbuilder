json.id @comment.id
json.text @comment.text
json.user_nickname @comment.user.nickname
json.user_id @comment.user_id
json.created_at @comment.created_at.strftime("%Y年%m月%d日 %H時%M分")
json.current_user @current_user
json.seller_id @item.user_id