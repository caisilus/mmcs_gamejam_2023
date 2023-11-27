$gtk.reset

class CreditsScene < Scene
    attr_accessor :args
  
    def initialize(args)
      super(args)
      @back_button = Button.new(x: 170, y: 660, w: 300, h: 80, color: Color.new(60, 60, 60, 100),
      text_color: Color.new(250, 250, 250), text: "Back")

      @back_button.on_mouse_click do |button, args|
      args.state.scene_manager.back_to_menu(args)
      end
    end
  
    def render_ui
      args.outputs.background_color = [0, 0, 0]
      args.outputs.sprites << { x: 0,
      y: 0,
      w: 1280,
      h: 720,
      path: 'sprites/title2.png',
      angle: args.state.rotation }
      super

      args.outputs.labels << {
                          x: 690,             
                          y: 320,                
                          text: "Над вот этим всем работали: ",   
                          size_enum: 10,                      
                          alignment_enum: 1,                     
                          r: 255,                    
                          g: 255,                      
                          b: 255,                    
                          a: 255,                     
                          font: "fonts/ofont.ru_Impact.ttf" }
      args.outputs.labels << {
                          x: 690,             
                          y: 280,                
                          text: "Сергей Горшков",   
                          size_enum: 10,                      
                          alignment_enum: 1,                     
                          r: 255,                    
                          g: 255,                      
                          b: 255,                    
                          a: 255,                     
                          font: "fonts/ofont.ru_Impact.ttf" }
      args.outputs.labels << {
                          x: 690,             
                          y: 250,                
                          text: "Олег Шевцов",   
                          size_enum: 10,                      
                          alignment_enum: 1,                     
                          r: 255,                    
                          g: 255,                      
                          b: 255,                    
                          a: 255,                     
                          font: "fonts/ofont.ru_Impact.ttf" }    
    args.outputs.labels << {
                          x: 690,             
                          y: 220,                
                          text: "Нина Таилова",   
                          size_enum: 10,                      
                          alignment_enum: 1,                     
                          r: 255,                    
                          g: 255,                      
                          b: 255,                    
                          a: 255,                     
                          font: "fonts/ofont.ru_Impact.ttf" }        
    args.outputs.labels << {
                          x: 690,             
                          y: 190,                
                          text: "Анастасия Виниченко",   
                          size_enum: 10,                      
                          alignment_enum: 1,                     
                          r: 255,                    
                          g: 255,                      
                          b: 255,                    
                          a: 255,                     
                          font: "fonts/ofont.ru_Impact.ttf" }    
    end
  end