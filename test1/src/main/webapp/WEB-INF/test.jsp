<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>댓글 시스템</title>
</head>
<body>

<div id="commentsContainer"></div>

<script>
    // 서버로부터 받은 가정된 댓글 데이터
    const comments = [
        { id: 1, parentCommentId: null, author: '작성자1', content: '첫 번째 댓글입니다.' },
        { id: 2, parentCommentId: 1, author: '작성자2', content: '첫 번째 댓글에 대한 대댓글입니다.' },
        // 여기에 더 많은 댓글 데이터가 있을 수 있습니다.
    ];

    function renderComments(comments, containerId, parentId = null) {
        const container = document.getElementById(containerId);
        comments.forEach(comment => {
            if (comment.parentCommentId === parentId) {
                const commentDiv = document.createElement('div');
                commentDiv.innerHTML = `
                    <div>
                        <p>${comment.author}</p>
                        <p>${comment.content}</p>
                    </div>
                `;
                container.appendChild(commentDiv);
                
                // 재귀적으로 대댓글 렌더링
                const repliesContainer = document.createElement('div');
                commentDiv.appendChild(repliesContainer);
                renderComments(comments, repliesContainer, comment.id);
            }
        });
    }

    renderComments(comments, 'commentsContainer');
</script>

</body>
</html>