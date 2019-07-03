/**
* Scope Facade 
* @file model.utilities.scopeService
* @author  David Fairfield (david.fairfield@gmail.com)
* @accessors true
* @extends model.abstract.baseservice
* */

component {
	/**
	* I am responsible for getting a scope and/or scope key
	* @access public
	* @returntype any
	* @output false
	*
	**/
        function get(required string someScope, string someKey, any defaultValue=''){
            var validScope = isValidScope(arguments.somescope);

            if(!isValidscope(arguments.somescope)){
                return "undefined";
            }else{
                // get the scope
                var scope = getScope(arguments.somescope);
                
                // if lockable, lock the scope 
                if( isLockable(arguments.somescope)){
                    lock scope=somescope timeout="5" throwontimeout="true" type="exclusive" {
                        // if someKey is passed in, and it doesn't exist, set defaultvalue
                        if (structKeyExists(arguments,"defaultValue") && structKeyExists(arguments,'someKey') && !structKeyExists(scope,arguments.someKey)) {
                            return arguments.defaultValue;
                        }
                        // if someKey is passed in, return it
                        if(StructKeyExists(arguments,'someKey')){
                            return scope[arguments.someKey];
                        }else{
                            // if no someKey is passed in, assuming expecting whole scope
                            return scope;
                        }
                    }
                }else{
                    // if someKey is passed in, and it doesn't exist, set defaultvalue
                    if (structKeyExists(arguments,"defaultValue") && structKeyExists(arguments,'someKey') && not structKeyExists(scope,arguments.someKey)) {
                            return arguments.defaultValue;
                        }
                        // if someKey is passed in, return it
                        if(StructKeyExists(arguments,'someKey')){
                            return scope[arguments.someKey];
                        }else{
                            // if no someKey is passed in, assuming expecting whole scope
                            return scope;
                        }
                    }
            }
        }

    /**
    * I am responsible for setting a scope someKey
    * @access public
    * @returntype void
    * @output false
    **/
        function set(required string somescope, required any key, any value=''){
            var validScope = isValidScope(arguments.somescope);

            if(ValidScope){
                var scope = getScope(arguments.somescope);
                if( isLockable(arguments.somescope)){
                    lock scope=arguments.somescope timeout="5" throwontimeout="true" type="exclusive" {
                        scope[arguments.key] = arguments.value;
                    }
                }else{
                    scope[arguments.key] = arguments.value;
                }
            }
        }

    /**
    * I am responsible for determining if scope key exists
    * @access public
    * @returntype boolean
    * @output false
    **/
        function exists(required string somescope, required string key){
            var validScope = isValidScope(arguments.somescope);

            if(ValidScope){
                // get the scope
                var scope = getScope(arguments.somescope);
                
                
                    return structKeyExists(scope,arguments.key)? true : false;
                
            }
            return false;
        }

    /**
    * I am responsible for deleteing a scope key
    * @access public
    * @returntype void
    * @output false
    **/
        function delete(required string somescope, required string key){
            var validScope = isValidScope(arguments.somescope);

            if(validScope){
                var scope = getScope(arguments.somescope);
                if(isLockable(arguments.somescope)){
                    lock scope=arguments.somescope timeout="5" throwontimeout="true" type="exclusive" {
                        if (exists(arguments.somescope,arguments.key)) {
                            structDelete(scope,arguments.key);
                        }
                    }
                }else{
                    if (exists(arguments.somescope,arguments.key)) {
                        structDelete(scope,arguments.key);
                    }
                }
            }
        }

    /**
    * I am responsible for setting scope params
    * @access public
    * @returntype void
    * @output false
    **/
        function setParam(required string somescope, required string key, any defaultValue, string type="any"){
            if(structKeyExists(arguments,"defaultvalue")){
                param name="#arguments.somescope#.#arguments.key#" type="#arguments.type#" default="#arguments.defaultValue#";
            }else{
                param name="#arguments.somescope#.#arguments.key#" type="#arguments.type#";
            }
        }

// ------------------------------------------------------------------- //        
// ------------------------ PRIVATE FUNCTIONS ------------------------ //
// ------------------------------------------------------------------- //        

    /**
    * I am responsible for returning a scope
    * @access private
    * @returntype struct
    * @output false
    **/
        function getScope(required string somescope){
            return StructGet(arguments.somescope);
        }


    /**
    * I am responsible for determining if scope is valid
    * @access private
    * @returntype boolean
    * @output false
    **/
        function isValidScope(required string somescope){
            if(listfind('server,application,session,request,cgi,url,form,client,cookie',arguments.somescope)){
                return true;
            }
            return false;
        }

    /**
    * I am responsible for determining if scope is lockable
    * @access private
    * @returntype boolean
    * @output false
    **/
        function isLockable(required string somescope){
            if(Listfind('application,session,request',somescope)) return true;
            return false;
        }

    /**
    * I am responsible for determining if a scope is writeable
    * @access private
    * @returntype boolean
    * @output false
    **/
        function canSet(required string scope){
            if(Listfind('server,application,session,request,url,form,client,cookie',somescope)) return true;
            return false;
        }

}