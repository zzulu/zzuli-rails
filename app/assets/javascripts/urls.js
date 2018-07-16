document.addEventListener('turbolinks:load', function(e) {
  var originInput = document.getElementById('url_origin');
  originInput && originInput.addEventListener('focus', function(e){
    this.parentElement.parentElement.classList.remove('active');
  });
  
  new ClipboardJS('#copy', {
    text: function(trigger) {
        var text = [];
        while (trigger = trigger.previousElementSibling)
          text.push(trigger.innerText);
        return text.reverse().join('');
    }
  });
});

