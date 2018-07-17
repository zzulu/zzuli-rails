document.addEventListener('turbolinks:load', function(e) {
  var originInput = document.getElementById('url_origin');
  originInput && originInput.addEventListener('focus', function(e){
    this.parentElement.parentElement.classList.remove('active');
  });
  
  var clipboard = new ClipboardJS('#copy', {
    text: function(trigger) {
        return trigger.previousElementSibling.innerText.replace(/\r?\n|\r/g,'');
    }
  });

  clipboard.on('success', function(e) {
    var box = e.trigger.parentElement;
    if (!box.classList.contains('copied')) {
      box.classList.add('copied');
      setTimeout(function() {
        box.classList.remove('copied');
      }, 2000);
    }
  });

  clipboard.on('error', function(e) {
    console.error('Action:', e.action);
    console.error('Trigger:', e.trigger);
  });
});
