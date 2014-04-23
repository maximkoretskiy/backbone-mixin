describe "Check MixinBackbone DI",->
  beforeEach ->
    @TestView = MixinBackbone(Backbone.View).extend {}
    @TestViewDI = Backbone.View.extend {}
    @view = new @TestView

  afterEach ->
    @view.remove()

  it "check DI keys works",->
    view1 = @view.getViewDI @TestViewDI
    diKey = "#{@TestViewDI._$_di}"
    view2 = @view.getViewDI @TestViewDI
    expect(diKey).toEqual "#{@TestViewDI._$_di}"

  it "check DI clean memory",->
    view = new @TestView
    diView = view.getViewDI @TestViewDI
    expect(view._diViewsKeys().length).toEqual 1
    spyOn(diView,"remove")
    view.remove()
    expect(diView.remove).toHaveBeenCalled()
    expect(view._diViewsKeys().length).toEqual 0

  it "checks DI preserve class",->
    view1 = @view.getViewDI @TestViewDI
    view2 = @view.getViewDI @TestViewDI
    expect(view1).toEqual view2

  it "check DI precerve instace",->
    diView = new @TestViewDI
    view1 = @view.getViewDI diView
    expect(diView).toEqual view1
    view2 = @view.getViewDI diView
    expect(view1).toEqual view2

  it "check DI with options",->
    view1 = @view.getViewDI type:@TestViewDI, key:"1"
    view2 = @view.getViewDI type:@TestViewDI, key:"2"
    expect(view1).not.toEqual view2