/**
 * 
 */
 
    // 아주 쉬운 드래그&드롭 UX(선택 사항)
    const dz = document.getElementById('dropzone');
    const fileInput = document.getElementById('file');

    dz.addEventListener('click', () => fileInput.click());
    ['dragenter','dragover'].forEach(ev =>
      dz.addEventListener(ev, (e)=>{ e.preventDefault(); dz.classList.add('is-over'); })
    );
    ['dragleave','drop'].forEach(ev =>
      dz.addEventListener(ev, (e)=>{ e.preventDefault(); dz.classList.remove('is-over'); })
    );
    dz.addEventListener('drop', (e)=>{
      fileInput.files = e.dataTransfer.files;
    });
    fileInput.addEventListener('change', ()=>{
      if(fileInput.files.length){
        dz.querySelector('.drop-hint strong').textContent = fileInput.files[0].name;
      }
    });
 