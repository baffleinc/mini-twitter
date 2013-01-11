# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  textbox = $('.field textarea')
  max = 140
  textbox.keyup ->
    count = $(this).val().length;
    remaining = max - count;
    counter = $('.letter-count');
    counter.text(remaining)
    
    if remaining < 0
      counter.addClass('error')
    else
      counter.removeClass('error')