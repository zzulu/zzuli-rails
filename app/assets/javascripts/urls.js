document.addEventListener('turbolinks:load', function(e) {
  var originInput = document.getElementById('url_origin');
  originInput.addEventListener('focus', function(e){
    this.parentElement.parentElement.classList.remove('active');
  });

  var copyToClipboard = document.getElementById('copy');
  copyToClipboard.addEventListener('click', function(e) {
    var aux = document.createElement("input");
    aux.setAttribute("value", `https://zzu.li/${document.getElementById('created-shortened').innerHTML}`);
    document.body.appendChild(aux);
    aux.select();
    document.execCommand("copy");
    document.body.removeChild(aux);
    alert('Copied!')
  });
});

