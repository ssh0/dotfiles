// leave at least 2 line with only a star on it below, or doc generation fails
/**
 *
 *
 * Placeholder for custom user javascript
 * mainly to be overridden in profile/static/custom/custom.js
 * This will always be an empty file in IPython
 *
 * User could add any javascript in the `profile/static/custom/custom.js` file
 * (and should create it if it does not exist).
 * It will be executed by the ipython notebook at load time.
 *
 * Same thing with `profile/static/custom/custom.css` to inject custom css into the notebook.
 *
 * Example :
 *
 * Create a custom button in toolbar that execute `%qtconsole` in kernel
 * and hence open a qtconsole attached to the same kernel as the current notebook
 *
 *    $([IPython.events]).on('app_initialized.NotebookApp', function(){
 *        IPython.toolbar.add_buttons_group([
 *            {
 *                 'label'   : 'run qtconsole',
 *                 'icon'    : 'icon-terminal', // select your icon from http://fortawesome.github.io/Font-Awesome/icons
 *                 'callback': function () {
 *                     IPython.notebook.kernel.execute('%qtconsole')
 *                 }
 *            }
 *            // add more button here if needed.
 *            ]);
 *    });
 *
 * Example :
 *
 *  Use `jQuery.getScript(url [, success(script, textStatus, jqXHR)] );`
 *  to load custom script into the notebook.
 *
 *    // to load the metadata ui extension example.
 *    $.getScript('/static/notebook/js/celltoolbarpresets/example.js');
 *    // or
 *    // to load the metadata ui extension to control slideshow mode / reveal js for nbconvert
 *    $.getScript('/static/notebook/js/celltoolbarpresets/slideshow.js');
 *
 *
 * @module IPython
 * @namespace IPython
 * @class customjs
 * @static
 */

// LIVE_REVEAL START

// to prevent timeout
requirejs.config({
    waitSeconds: 60
});

$([IPython.events]).on('app_initialized.NotebookApp', function(){

     require(['nbextensions/livereveal/main'],function(livereveal){
       // livereveal.parameters('theme', 'transition', 'fontsize', static_prefix);
       //   * theme can be: simple, sky, beige, serif, solarized
       //   (you will need aditional css for default, night, moon themes).
       //   * transition can be: linear, zoom, fade, none
       livereveal.parameters('simple', 'fade');
       console.log('Live reveal extension loaded correctly');
    // http://hannes-brt.github.io/blog/2013/08/11/ipython-slideshows-will-change-the-way-you-work/
    function hideElements(elements, start) {
        for(var i = 0, length = elements.length; i < length;i++) {
            if(i >= start) {
                elements[i].style.display = "none";
            }
        }
    }
    var input_elements = document.getElementsByClassName('input');
    hideElements(input_elements, 0);
    var prompt_elements = document.getElementsByClassName('prompt');
    hideElements(prompt_elements, 0);
    var buttonHelp_elements = document.getElementsByClassName('buttonHelp');
    hideElements(buttonHelp_elements, 0);
    var buttonExit_elements = document.getElementsByClassName('buttonExit');
    hideElements(buttonExit_elements, 0);
     });

});


// LIVE_REVEAL END
