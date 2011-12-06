feature 'Queries', ->
#  i = 1
#  afterEach -> browser.page.render "shots/#{i++} #{feature.currentTestFullTitle}.png"
  
  it "throws an error if no elements found", ->
    error = false
    try $('banana')
    catch e
      error = true
    finally error.should.equal true
  
  it "finds elements using xpath", ->
    $(xpath: '//*[text()="first item"]').text.should.equal 'first item'
  
  it "finds elements by their text content", ->
    $(text: 'first item').text.should.equal 'first item'
  
  it "finds links by their text", ->
    $(link: 'subpage').attr('href').should.equal '/subpage'
    
  it "finds fields by their label", ->
    $(field: 'info text:').value.should.equal 'initial value'
    $(field: 'info text').value.should.equal 'initial value'
    $(field: 'test input').value.should.equal 'test value'
  
  it "finds buttons by their caption", ->
    $(button: 'set info').attr('id').should.equal 'setInfo'
    $(button: 'submit test').attr('id').should.equal 'submitButton'

  describe '#text', ->
    it "returns element's text content", ->
      $('title').text.should.equal 'WebSpecter Test Server'
  
  describe '#value', ->
    it "returns field's value", ->
      $('#infoText').value.should.equal 'initial value'
  
  describe '#attr', ->
    it "returns element's attribute", ->
      $('#link').attr('href').should.equal '/subpage'
  
  describe '#click', ->
    it "fires a mousedown event", ->
      $('#mousedown').click()
      $('#info').text.should.equal 'mousedown fired'
    
    it "fires a mouseup event", ->
      $('#mouseup').click()
      $('#info').text.should.equal 'mouseup fired'
    
    it "fires a click event", ->
      $('#click').click()
      $('#info').text.should.equal 'click fired'
    
    describe "when a link is clicked", ->
      before (done) -> $(link: 'subpage').click(done)
      after (done) -> $(link: 'home').click(done)
      it "follows it", ->
        $('h1').text.should.equal 'subpage'
  
  describe '#fill', ->
    it "fills an input with text", ->
      $('input[name="infoText"]').fill 'input text'
      $(button: 'set info').click()
      $('#info').text.should.equal 'input text'
  
  describe "when there are more elements", ->
    it "lets us access them with an index", ->
      $('ol li')[0].text.should.include.string 'first'
      $('ol li')[1].text.should.include.string 'second'
      $('ol li')[2].text.should.include.string 'third'
    
    it "lets us iterate them with a for loop", ->
      element.text.should.include.string 'item' for element in $('ol li')
    
    it "lets us iterate them with #each", ->
      $('ol li').each (element) -> element.text.should.include.string 'item'
    
    it "lets us access the last element with #last", ->
      $('ol li').last.text.should.include.string 'third'
      
