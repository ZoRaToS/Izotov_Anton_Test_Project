
describe("Test successful feefback",function(){
    Cypress.on('uncaught:exception',(err,runnable) => {
        return false;
    });
    it("Form with valid data", function(){
        //Visit site with feedback form
        cy.visit("https://www.globalsqa.com/samplepagetest/")
        //Filling "Name" field
        cy.get('input[id="g2599-name"]').type('Anton', {timeuot:3000})
        ////Filling "Email" field
        cy.get('input[id="g2599-email"]').type('dovakin.izotov1994@gmail.com',
        {timeuot:3000})
        //Select "Experience (In Years)" 
        cy.get('#g2599-experienceinyears').select('7-10').should('have.value', '7-10')
        // Check the "Automation Testing" checkbox
        cy.get('input[type="checkbox"]').check('Automation Testing')
        // Check the "Other" radio
        cy.get('input[type="radio"]').check('Other')
        //Filling the "Comment" textarea 
        cy.get('textarea[id="contact-form-comment-g2599-comment"]').type('Testing is cool')
        //Clicking "Submit" button
        cy.get('button[type="submit"]').click()
    })
})

describe("Test feefback form with empty fields",function(){
    Cypress.on('uncaught:exception',(err,runnable) => {
        return false;
    });
    it("Form with empty fields", function(){
        //Visit site with feedback form
        cy.visit("https://www.globalsqa.com/samplepagetest/")
        //Clicking "Submit" button
        cy.get('[type="submit"]').click()
        cy.get('input:invalid').should('have.length', 2)
        
    })
})