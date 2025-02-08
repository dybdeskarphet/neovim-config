return { 
  'echasnovski/mini.nvim', version = '*',
  config = function()
    require('mini.comment').setup()
    require('mini.surround').setup()
    -- Directly calling starter doesn't work
    starter = require('mini.starter')
    starter.setup({
      autoopen = true,
      evaluate_single = true,
      items = {
          starter.sections.builtin_actions(),
          starter.sections.recent_files(10, true, true)
      },

    header = [[ @@@@@@   @@@  @@@   @@@@@@   @@@@@@@   @@@@@@@   @@@  @@@  @@@@@@@@  @@@@@@@  
@@@@@@@   @@@  @@@  @@@@@@@@  @@@@@@@@  @@@@@@@@  @@@  @@@  @@@@@@@@  @@@@@@@  
!@@       @@!  !@@  @@!  @@@  @@!  @@@  @@!  @@@  @@!  @@@  @@!         @@!    
!@!       !@!  @!!  !@!  @!@  !@!  @!@  !@!  @!@  !@!  @!@  !@!         !@!    
!!@@!!    @!@@!@!   @!@!@!@!  @!@!!@!   @!@@!@!   @!@!@!@!  @!!!:!      @!!    
 !!@!!!   !!@!!!    !!!@!!!!  !!@!@!    !!@!!!    !!!@!!!!  !!!!!:      !!!    
     !:!  !!: :!!   !!:  !!!  !!: :!!   !!:       !!:  !!!  !!:         !!:    
    !:!   :!:  !:!  :!:  !:!  :!:  !:!  :!:       :!:  !:!  :!:         :!:    
:::: ::    ::  :::  ::   :::  ::   :::   ::       ::   :::   :: ::::     ::    
:: : :     :   :::   :   : :   :   : :   :         :   : :  : :: ::      :]],
      footer = [[]],
      content_hooks = {
          starter.gen_hook.indexing('all', {'Builtin actions'}),
          starter.gen_hook.adding_bullet(" "),
          starter.gen_hook.aligning("center", "center")
      },
      query_updaters = 'abcdefghijklmnopqrstuvwxyz0123456789_-.',
      silent = true
    })
  end
}
