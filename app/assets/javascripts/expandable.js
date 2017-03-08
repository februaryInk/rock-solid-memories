/*
 * TODO: Add a button to expand all, and a button to collapse all.
 * TODO: Make expandables open initially, then close them with JavaScript on page load,
 * so non-JavaScript users can see them.
 */

$( document ).on( 'click', '.js-expandable', function ( evt, el ) {
    if ( $( this ).hasClass( '-open' ) ) {
        $( this ).find( '.js-expandable-hidden' ).slideUp( 250 );
        $( this ).removeClass( '-open' );
    } else {
        $( this ).find( '.js-expandable-hidden' ).slideDown( 250 );
        $( this ).addClass( '-open' );
    }
} );
