/**
* Utility Service
* @file model.utilities.utilityService
* @author  David Fairfield (david.fairfield@gmail.com)
* @accessors true
* */
component {

    /**
     * I am responsible for returning the local hostname of the server
     * @access public
     * @returntype string
     * @output false
     **/
        function getHostname() {
            return createObject( 'java', 'java.net.InetAddress' ).getLocalHost().getHostName();
        }

    /**
    * I am responsible for returning a percentage
    * @access public
    * @returntype any
    * @output false
    **/
        function calulatePercentage(Value,Maximum) {
            try{
                return decimalformat(((Value/Maximum)*100));
            }catch(any e){
                return 0;
            }
        }

    /**
    * I am responsible for performing an http request and returning the content
    * @access public
    * @returntype string
    * @output false
    **/
        function getHTTPRequest(
            required string urlString, 
            array params=[], 
            string method="get"){

            try{
                /* create new http service */ 
                var httpService = new http(); 
                /* set attributes using implicit setters */ 
                httpService.setMethod(arguments.method); 
                httpService.setCharset("utf-8"); 
                httpService.setUrl(arguments.urlString); 

                /* add httpparams using addParam() */ 
                for(var key in arguments.params){
                    httpService.addParam(type=key.type,name=key.name,value=key.value); 
                }
            
                /* make the http call to the URL using send() */ 
                result = httpService.send().getPrefix(); 

            }catch(any e){
                return 'HTTP Error 404';
            }   

            return result.fileContent;

        }

    /**
    * I am responsible for converting an ORM object
    * @access public
    * @returntype any
    * @output false
    **/
        function deORM( obj ){ return deserializeJson( serializeJson( obj ) ); }    

}