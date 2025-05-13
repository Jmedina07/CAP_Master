using {com.logaligroup as entities } from '../db/schema';
//Conectar con una API
using {API_BUSINESS_PARTNER as cloud } from './external/API_BUSINESS_PARTNER';
//Conectar On premise
//using {API_BUSINESS_PARTNER_CLUD as onpremise} from './external/API_BUSINESS_PARTNER_CLUD';
service LogaliGroup {

    type dialog {
        option : String(10);
        amount: Integer;
    }

 /*   @cds.odata.bindingparameter.name : '_it'
    @Common: {
        SideEffects : {
            $Type : 'Common.SideEffectsType',
            TargetProperties : [
                '_it/*',
            ],
        },
    }*/
    action setSales (id : String, year : Integer, month : Integer, quantity : Integer) returns String;

    entity Products         as projection on entities.Products;
    entity ProductDetails   as projection on entities.ProductDetails;
    entity Suppliers        as projection on entities.Suppliers;
    entity Contacts         as projection on entities.Contacts;
    entity Reviews          as projection on entities.Reviews;
    
    entity Inventories      as projection on entities.Inventories actions {
        @Core.OperationAvailable: {
            $edmJson: {
                $If:[
                    {
                        $Eq: [
                            {
                                $Path: 'in/product/IsActiveEntity'
                            },
                            false
                        ]
                    },
                    false,
                    true
                ]
            }
        }
        @Common: {
            SideEffects : {
                $Type : 'Common.SideEffectsType',
                TargetProperties : [
                    'in/quantity',
                ],
                TargetEntities : [
                    in.product
                ],
            },
        }
        action setStock (
            in: $self,
            option : dialog:option,
            amount : dialog:amount
        )
    };
    entity Sales            as projection on entities.Sales;
    /**Code List */
    entity Status           as projection on entities.Status;
    /** Value Helps */
    entity VH_Categories    as projection on entities.Categories;
    entity VH_SubCategories as projection on entities.SubCategories;
    entity VH_Departments   as projection on entities.Departments;
    entity Options as projection on entities.Options; //TEST JMJ

    /*Entidades Externas*/

    entity CBusinessPartner as projection on cloud.A_BusinessPartner{
        key BusinessPartner as ID,
        FirstName as FirstName,
        LastName as LastName
    };
    
    entity CSuppliers as projection on cloud.A_Supplier{
        Supplier as ID,
        SupplierName as SupplierName,
        SupplierFullName as FullName
    };
/*Conectar Onpremise
    entity CCustomer as projection on onpremise.A_Customer {
        Customer as ID,
        CustomerName,
        CustomerFullName
    };
     */
    
};