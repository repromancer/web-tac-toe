module ComputerPlayerLogic

  def center
    4
  end

  def corners
    [0,2,6,8]
  end
  def sides
    [1,3,5,7]
  end



  def can_win?(token, board)
    Game::WIN_COMBINATIONS.detect do |combo|
      combo.count{|i| board.cells[i] == token} == 2 &&
      combo.count{|i| board.cells[i] == '0'} == 1
    end
  end

  def win(game)
    can_win?('1', game).detect{|i| game.cells[i] == '0'}
  end

  def block_opponent(game)
    can_win?('2', game).detect{|i| game.cells[i] == '0'}
  end



  def center_free?(game)
    ! game.cell_taken?(center)
  end



  def corners_occupied?(game)
    occupied = corners.select do |corner|
      game.cell_taken?(corner) &&
      game.cells[corner] == '2'
    end
    occupied if occupied.any?
  end

  def opposing_corner_free?(game)
    corners_occupied?(game).detect do |corner|
      case corner
      when 0
        game.cell_taken?(8) == false
      when 2
        game.cell_taken?(6) == false
      when 6
        game.cell_taken?(2) == false
      when 8
        game.cell_taken?(0) == false
      end
    end
  end

  def take_opposing_corner(game)
    case opposing_corner_free?(game)
    when 0
      8
    when 2
      6
    when 6
      2
    when 8
      0
    end
  end



  def corner_free?(game)
    corners.detect do |corner|
      game.cell_taken?(corner) == false
    end
  end

  def take_corner(game)
    corner_free?(game)
  end

  def side_free?(game)
    sides.detect do |side|
      game.cell_taken?(side) == false
    end
  end

  def take_side(game)
    side_free?(game)
  end



  def make_move(game)

    if can_win?('1', game)
      win(game)

    elsif can_win?('2', game)
      block_opponent(game)

    elsif center_free?(game)
      center

    elsif corners_occupied?(game) && opposing_corner_free?(game)
      take_opposing_corner(game)

    elsif corner_free?(game)
      take_corner(game)

    elsif side_free?(game)
      take_side(game)

    end

  end



end
