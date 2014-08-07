(function(d) {
    var
        config = {
            kitId: 'ocw5bqy',
            scriptTimeout: 3000
        },
        doc = d.documentElement,
        timeout = setTimeout(
            function() {
                doc.className = doc.className.replace(
                    /\bwf-loading\b/g, ""
                ) + " wf-inactive";
            },
            config.scriptTimeout),
        loaded = false;
    
    doc.className += " wf-loading";

    // var tk = d.createElement("script");
    // tk.src = '//use.typekit.net/' + config.kitId + '.js';
    // tk.async = true;
    // tk.onload = tk.onreadystatechange = function() {
        // var state = this.readyState;
        // if(loaded || state && state != "complete" && state != "loaded")
        //     return;
        // loaded = true;
        // clearTimeout(timeout);
        // try {
        //     Typekit.load(config)
        // } catch(e) { }
    // };

    var loadTypekit = function() {
        //= require 'typekit-guts'

        clearTimeout(timeout);
        try {
            Typekit.load(config)
        } catch(e) {
            if(console && console.log)
                console.log(e);
        }
    };

    setTimeout(loadTypekit, 0);

    // var firstScript = d.getElementsByTagName("script")[0];
    // firstScript.parentNode.insertBefore(tk, firstScript);
})(document);
