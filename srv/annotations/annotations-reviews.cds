using {LogaliGroup as service} from '../service';

annotate service.Reviews with {
    rating     @title: 'Rating';
    date       @title: 'Date';
    user       @title: 'User';
    reviewText @title: 'Review Text';
};

annotate service.Reviews with @(
    UI.HeaderInfo         : {
        $Type         : 'UI.HeaderInfoType',
        TypeName      : 'Review',
        TypeNamePlural: 'Reviews',
        Title         : {
            $Type: 'UI.DataField',
            Value: product.productName
        },
        Description   : {
            $Type: 'UI.DataField',
            Value: product.product
        }
    },
    UI.LineItem           : [
        {
            $Type                : 'UI.DataFieldForAnnotation',
            Target               : '@UI.DataPoint',
            Label                : 'Rating',
            ![@HTML5.CssDefaults]: {
                $Type: 'HTML5.CssDefaultsType',
                width: '10rem'
            },
        },
        {
            $Type: 'UI.DataField',
            Value: date
        },
        {
            $Type: 'UI.DataField',
            Value: user,
            Label: 'User'
        },
        {
            $Type: 'UI.DataField',
            Value: reviewText
        }
    ],
    UI.DataPoint          : {
        $Type        : 'UI.DataPointType',
        Value        : rating,
        Visualization: #Rating
    },
    UI.FieldGroup #Reviews: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Value: rating,
                Label: 'Rating'
            },
            {
                $Type: 'UI.DataField',
                Value: date,
                Label: 'Date'
            },
            {
                $Type: 'UI.DataField',
                Value: user,
                Label: 'User'
            },
            {
                $Type: 'UI.DataField',
                Value: reviewText,
                Label: 'Review Text'
            }
        ],
    },
    UI.Facets             : [{
        $Type : 'UI.ReferenceFacet',
        Target: '@UI.FieldGroup#Reviews',
        Label : 'Reviews',
        ID    : 'Reviews'
    }],
);