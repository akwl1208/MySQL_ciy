-- <순위 함수>
-- ctrl + B : 쿼리문 정렬 정리
/* row_number() : 순서를 세서 1부터 숫자를 할당, over()에 있는 것을 기준으로
 - 순서라는 속성을 하나 만들고(실제 테이블에 속성을 추가하는 것이 아니라 결과화면에 추가), 그 속성값으로 1부터
 하나씩 증가하도록 하는데 기준을 over() 안에 있는 정렬방법을 기준으로 삼음
 - 같은 값이 있으면 번호가 다름
 */
 -- 일반 게시글을 등록 순서대로 정렬
SELECT 
    row_number() over(order by bo_num asc)순서, board.*
FROM
    community.board
WHERE
    bo_ca_name = '일반';
    
/* rank() : row_num와 다르게 값이 같으면 같은 번호을 가지고, 다음 번호는 생략
dense_rank() : 다음 번호를 생략하지 않음*/
-- 일반 게시글을 비추천 순으로 정렬 : rank()
SELECT 
    rank() over(order by bo_down desc)순서, board.*
FROM
    community.board
WHERE
    bo_ca_name = '일반'
order by bo_down desc, 순서 asc;

-- dense_rank()
SELECT 
    dense_rank() over(order by bo_down desc)순서, board.*
FROM
    community.board
WHERE
    bo_ca_name = '일반'
order by bo_down desc, 순서 asc;