export default class BaseModel{
    constructor(){
    }
    
    excludeProperties(properties) {
        properties.forEach((property) => {
           Object.defineProperty(this, property, {
               writable: true,
                configurable: true,
                enumerable: false
           }); 
        });
    }
}