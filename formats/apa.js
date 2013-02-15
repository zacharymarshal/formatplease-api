// This will make sure that h3, h4 and h5 tags all display inline
$(function(){
  $('h3, h4, h5').each(function(){
    var $this;
    $this = $(this);
    $this.next('p').prepend($this);
  });
});