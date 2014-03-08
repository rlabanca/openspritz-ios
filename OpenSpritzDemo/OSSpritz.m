//
//  OSSpritz.m
//  OpenSpritzDemo
//
//  Created by Francesco Mattia on 07/03/14.
//  Copyright (c) 2014 Fr4ncis. All rights reserved.
//

#import "OSSpritz.h"

@implementation OSSpritz

+ (int)offsetForWord:(NSString*)word
{
    return 4;
}

+ (NSArray*)spritzString:(NSString*)text
{
    return [text componentsSeparatedByString:@" "];
}

// Create the view from the remote resource.
//function create_spritz(){
//    
//    spritz_loader = function() {
//        
//        $.get("https://rawgithub.com/Miserlou/OpenSpritz/master/spritz.html", function(data){
//            
//            if (!($("#spritz_container").length) ) {
//                $("body").prepend(data);
//            }
//            
//            // I suppose it's better to add that to spritz.html
//            $('#spritz_selector')
//            .after('<input type="range" id="spritz_slider" min="1" max="10" value="1">')
//            .after('<button type="button" id="spritz_toggle">Play</button>');
//        },'html');
//    };
//    
//    load_jq(spritz_loader);
//}


// The meat!
//function spritzify(input){

//- (void)spritzString:(NSString*)text
//{
//    int wpm = 600;
//    float msecPerWord = 60000 / (float)wpm;
//    
//    NSMutableArray *words = [[text componentsSeparatedByString:@" "] mutableCopy];
//
//    int t = 0;
//    
//    for (int i = 0; i < [words count]; i++) {
//        NSString *word = words[i];
//        if ([word rangeOfString:@"."].location != NSNotFound)
//        {
//            
//        }
//        
//    }
//    
//
//    
//    for (var i=0; i<all_words.length; i++){
//        
//        
//        // replace period with dot glyph
//        if(all_words[i].indexOf('.') != -1){
//            temp_words[t] = all_words[i].replace('.', '&#8226;');
//        }
//        
//        
//        // comma time
//        // $commatime = 2;
//        
//        // fullstop time
//        // 3
//        
//        // Double up on long words and words with commas.
//        if((all_words[i].indexOf(',') != -1 || all_words[i].indexOf(':') != -1 || all_words[i].indexOf('-') != -1 || all_words[i].indexOf('(') != -1|| all_words[i].length > 8) && all_words[i].indexOf('.') == -1){
//            temp_words.splice(t+1, 0, all_words[i]);
//            temp_words.splice(t+1, 0, all_words[i]);
//            t++;
//            t++;
//        }
//        
//        // length
//        // $time += sqrt(length($word)) * $lentime;
//
//        
//        // Add an additional space after punctuation.
//        if(all_words[i].indexOf('.') != -1 || all_words[i].indexOf('!') != -1 || all_words[i].indexOf('?') != -1 || all_words[i].indexOf(':') != -1 || all_words[i].indexOf(';') != -1|| all_words[i].indexOf(')') != -1){
//            temp_words.splice(t+1, 0, "."); // add three dots if
//            temp_words.splice(t+1, 0, ".");
//            temp_words.splice(t+1, 0, ".");
//            t++;
//            t++;
//            t++;
//        }
//        
//        t++;
//        
//    }

    
//    all_words = temp_words.slice(0);
//    
//    var currentWord = 0;
//    var running = false;
//    var spritz_timers = new Array();
//    
//    $('#spritz_toggle').click(function() {
//        if(running) {
//            stopSpritz();
//        } else {
//            startSpritz();
//        }
//    });
//    
//    $('#spritz_slider').change(function() {
//        updateValues($('#spritz_slider').val() - 1);
//    });
//    
//    function updateValues(i) {
//        $('#spritz_slider').val(i);
//        var p = pivot(all_words[i]);
//        $('#spritz_result').html(p);
//        currentWord = i;
//    }
//    
//    function startSpritz() {
//        $('#spritz_toggle').html('Stop');
//        running = true;
//        // Set slider max value
//        $('#spritz_slider').attr("max", all_words.length);
//        
//        spritz_timers.push(setInterval(function() {
//            updateValues(currentWord);
//            currentWord++;
//            if(currentWord >= all_words.length) {
//                currentWord = 0;
//                stopSpritz();
//            }
//        }, ms_per_word));
//    }
//    
//    function stopSpritz() {
//        for(var i = 0; i < spritz_timers.length; i++) {
//            clearTimeout(spritz_timers[i]);
//        }
//        $('#spritz_toggle').html('Play');
//        running = false;
//    }
//}

// Find the red-character of the current word.
//function pivot(word){
//    var length = word.length;
//    
//    // Longer words are "right-weighted" for easier readability.
//    if(length<6){
//        
//        var bit = 1;
//        while(word.length < 22){ // fino a 22 char aggiunge dots a sx e dx
//            if(bit > 0){
//                word = word + '.';
//            }
//            else{
//                word = '.' + word;
//            }
//            bit = bit * -1;
//        }
//        
//        var start = '';
//        var end = '';
//        if((length % 2) === 0){
//            start = word.slice(0, word.length/2);
//            end = word.slice(word.length/2, word.length);
//        } else{
//            start = word.slice(0, word.length/2);
//            end = word.slice(word.length/2, word.length);
//        }
//        
//        var result;
//        result = "<span class='spritz_start'>" + start.slice(0, start.length -1);
//        result = result + "</span><span class='spritz_pivot'>";
//        result = result + start.slice(start.length-1, start.length);
//        result = result + "</span><span class='spritz_end'>";
//        result = result + end;
//        result = result + "</span>";
//    }
//    
//    else{
//        
//        var tail = 22 - (word.length + 7);
//        word = '.......' + word + ('.'.repeat(tail));
//        
//        var start = word.slice(0, word.length/2);
//        var end = word.slice(word.length/2, word.length);
//        
//        var result;
//        result = "<span class='spritz_start'>" + start.slice(0, start.length -1);
//        result = result + "</span><span class='spritz_pivot'>";
//        result = result + start.slice(start.length-1, start.length);
//        result = result + "</span><span class='spritz_end'>";
//        result = result + end;
//        result = result + "</span>";
//        
//    }
//    
//    result = result.replace(/\./g, "<span class='invisible'>.</span>");
//    
//    return result;
//}
//
//// Get the currently selected text, if any.
//// Shameless pinched from StackOverflow.
//function getSelectionText() {
//    var text = "";
//    if (typeof window.getSelection != "undefined") {
//        var sel = window.getSelection();
//        if (sel.rangeCount) {
//            var container = document.createElement("div");
//            for (var i = 0, len = sel.rangeCount; i < len; ++i) {
//                container.appendChild(sel.getRangeAt(i).cloneContents());
//            }
//            text = container.innerText || container.textContent;
//        }
//    } else if (typeof document.selection != "undefined") {
//        if (document.selection.type == "Text") {
//            text = document.selection.createRange().text;
//        }
//    }
//    if(text === ""){
//        return false;
//    }
//    else{
//        return text;
//    }
//}
//
//// Uses the Readability API to get the juicy content of the current page.
//function spritzifyURL(){
//    var url = document.URL;
//    
//    $.getJSON("https://www.readability.com/api/content/v1/parser?url="+ encodeURIComponent(url) +"&token=" + readability_token +"&callback=?",
//              function (data) {
//                  
//                  if(data.error){
//                      $('#spritz_result').html("Article extraction failed. Try selecting text instead.");
//                      return;
//                  }
//                  
//                  var title = '';
//                  if(data.title !== ""){
//                      title = data.title + ". ";
//                  }
//                  
//                  var author = '';
//                  if(data.author !== null){
//                      author = "By " + data.author + ". ";
//                  }
//                  
//                  var body = jQuery(data.content).text(); // Textify HTML content.
//                  body = $.trim(body); // Trim trailing and leading whitespace.
//                  body = body.replace(/\s+/g, ' '); // Shrink long whitespaces.
//                  
//                  var text_content = title + author + body;
//                  text_content = text_content.replace(/\./g, '. '); // Make sure punctuation is apprpriately spaced.
//                  text_content = text_content.replace(/\?/g, '? ');
//                  text_content = text_content.replace(/\!/g, '! ');
//                  spritzify(text_content);
//              });
//    
//}
//
////////
//// Helpers
////////
//
//// This is a hack using the fact that browers sequentially id the timers.
//function clearTimeouts(){
//    var id = window.setTimeout(function() {}, 0);
//    
//    while (id--) {
//        window.clearTimeout(id);
//    }
//}
//
//// Let strings repeat themselves,
//// because JavaScript isn't as awesome as Python.
//String.prototype.repeat = function( num ){
//    return new Array( num + 1 ).join( this );
//}

@end
