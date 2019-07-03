/**
* String Service
* @file model.utilities.stringService
* @author  David Fairfield (david.fairfield@gmail.com)
* @accessors true
* @extends model.abstract.baseservice
**/
component {
	/**
	* I am responsible for capitalize the character or every word in passed in string
	* @access public
	* @returntype string
	* @output false
	**/
        function CapFirst(required string inputString){
            return rereplace(lcase(arguments.inputString), "(\b\w)", "\u\1", "all");
        }	

    /**
    * I am responsible for determinging if a string contains a substring
    * @access public
    * @returntype boolean
    * @output false
    **/
        function containsString(required string substr, required string str){
            var results = false;

            if(arguments.str contains arguments.substr){ results = true ; }

            return results;
        }

    /**
    * I am responsible for unindenting a string
    * @access public
    * @returntype string
    * @output false
    **/
    function unIndent(str) {
        var lines = str.split("\n");
        var i = 0;
        var minSpaceDist = 9999;
        var newStr = "";

        for(i=1; i lte arrayLen(lines); i=i+1) {
            if (len(trim(lines[i]))) {
                minSpaceDist = max( min(minSpaceDist, reFind("[\S]",lines[i])-1), 0);
            }
        }

        for(i=1; i lte arrayLen(lines); i=i+1) {
            if (len(lines[i])) {
                newStr = newStr & removeChars(lines[i], 1, minSpaceDist);
            }
            newStr = newStr & chr(10);
        }
        return newStr;
    }

    /**
    * I am responsible for returning the time interval from now();
    * @access public
    * @returntype string
    * @output false
    **/
    function getTimeInterval(date, datemask="dddd dd mmmm yyyy"){
        var timeinseconds = 0;
        var result = "";
        var interval = "";
        if(IsDate(arguments.date)){
            timeinseconds = DateDiff('s', arguments.date, Now());
            // less than a minute
            if(timeinseconds < 60){ result = " less than a minute ago"; }
            // less than an hour
            else if (timeinseconds < 3600){
                interval = Int(timeinseconds / 60);
                // more than 1 minute
                if (interval > 1) result = interval & " minutes ago";
                else result = interval & " minute ago";
            }
            // less than 24 hours
            else if (timeinseconds < (86400) && Hour(Now()) >= Hour(arguments.date)){
                interval = Int(timeinseconds / 3600);
                // more than 1 hour
                if (interval > 1) result = interval & " hours ago";
                else result = interval & " hour ago";
            }
            // less than 48 hours
            else if (timeinseconds < 172800){
                result = "yesterday" & " at " & TimeFormat(arguments.date, "HH:MM");
            }
            // return the date
            else{
                result = DateFormat(arguments.date, arguments.datemask) & " at " & TimeFormat(arguments.date, "HH:MM");
            }
        }
        return result;
    }

    /**
    * I am responsible for checking to see if string is upper case
    * @access public
    * @returntype boolean
    * @output false
    **/
        function isUpperCase(required string str){
            var results = false;
            var thisLen = len(arguments.str);
            var aLen = 0;
            var test = reMatch('[A-Z]+', arguments.str);
            if(isArray(test) && ArrayLen(test)){
                aLen = len(test[1]);
                if(aLen eq ThisLen){
                    results = true;
                }

            }
            return results;
        }

    /**
    * I am responsible for returning a snippet of a string
    * @access public
    * @returntype string
    * @output false
    **/
        function snippet(required string str, numeric characterCount = 100) {
            local.result = Trim(reReplace(arguments.str, "<[^>]{1,}>", " ", "all"));
            if (Len(local.result) > arguments.characterCount + 10) {
                return Trim(Left(local.result, arguments.characterCount));
            } else {
                return local.result;
            }
        }

    /**
    * I am responsible for returning formatted percentage
    * @access public
    * @returntype string
    * @output false
    **/
        function percentageFormat(required numeric percentage){
            var thisPercentage = numberformat(arguments.percentage,'___.00');

            thisPercentage = replacenocase(thisPercentage,'.00','','all');
            thisPercentage &='%';

            return trim(thisPercentage);
        }

}