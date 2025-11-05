 // <!-- (선택) Enter 키로 로그인 -->
  
    (function(){
      const form = document.querySelector('form');
      form.addEventListener('keydown', function(e){
        if(e.key === 'Enter') {
          // 버튼 포커스가 링크 위일 때는 기본 동작 유지
        }
      });
    })();
 