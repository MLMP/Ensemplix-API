class V2::RegionsController < ApplicationController

  # GET /regions/
  # Информация о регионах.
  def index
    @regions = Region.all
    @regions = @regions.where("world = ?", params[:world]) if params.has_key? :world

    if params.has_key? :offset
      @regions = @regions.offset(params[:offset])
    end

    if @regions.empty?
      render :json => {
          :error => "Regions not found.",
          :world => params[:world]
      }, :status => 422
      return;
    end

    @count = @regions.count()
    @regions = @regions.limit(100)

    @regions.each do |region|
      region_name = region['region']
      world = region['world']
      region['owners'] = Owner.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['members'] = Member.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['flags'] = Flag.where("region = ? AND world = ?", region_name, world).pluck("flag")
      region['children'] = Child.where("parent = ? AND world = ?", region_name, world).pluck("child")
      parent = Child.select("parent").where("child = ? AND world = ?", region_name, world).take()

      if !parent.nil?
        region['parent'] = parent['parent']
      else
        region['parent'] = nil
      end
    end

    render :json => {
        :regions => @regions,
        :count => @count,
        :offset => params[:offset],
        :world => params[:world]
    }

  end

  # GET /region/:region/:world/
  # Информация о регионе.
  def info
    if !params.has_key? :region
      render json: {error: "Please provide region."}, :status => 422
      return;
    end

    if !params.has_key? :world
      render json: {error: "Please provide world."}, :status => 422
      return;
    end

    @region = Region.where("region = ? AND world = ?", params[:region], params[:world]).take()

    if @region.nil?
      render :json => {
          :error => "Region not found.",
          :region => params[:region],
          :world => params[:world]
      }, :status => 422
      return;
    end

    @owners = Owner.where("region = ? AND world = ?", params[:region], params[:world]).pluck("player")
    @members = Member.where("region = ? AND world = ?", params[:region], params[:world]).pluck("player")
    @flags = Flag.where("region = ? AND world = ?", params[:region], params[:world]).pluck("flag")
    @children = Child.where("parent = ? AND world = ?", params[:region], params[:world]).pluck("child")
    @parent = Child.select("parent").where("child = ? AND world = ?", params[:region], params[:world]).take()

    render :json => {
        :region => @region,
        :owners => @owners,
        :members => @members,
        :flags => @flags,
        :children => @children,
        :parent => @parent
    }
  end

  # GET /regions/location/
  # Получение информации о ближайший регионах.
  def location
    if !params.has_key? :x
      render json: {error: "Please provide X coordinate."}, :status => 422
      return;
    end

    if !params.has_key? :z
      render json: {error: "Please provide Z coordinate."}, :status => 422
      return;
    end

    if !params.has_key? :world
      render json: {error: "Please provide world."}, :status => 422
      return;
    end
    
    @radius = 250;
    
    if params.has_key? :radius
      @radius = params[:radius].to_i
    end
    
    if @radius > 250
      @radius = 250        
    end
    
    if @radius < 0
      @radius = 0        
    end
    
    @regions = Region.where("min_x <= :x + :radius AND max_x > :x - :radius AND min_z < :z + :radius AND max_z > :z - :radius
         AND world = :world", x: params[:x], z: params[:z], radius: @radius, world: params[:world])

    @count = @regions.count()
    @regions = @regions.limit(100)

    if params.has_key? :offset
      @regions = @regions.offset(params[:offset])
    end

    if @regions.empty?
      render :json => {
          :error => "No regions found.",
          :x => params[:x],
          :z => params[:z],
		  :radius => @radius,
          :world => params[:world],
          :offset => params[:offset]
      }, :status => 422
      return;
    end

    @regions.each do |region|
      region_name = region['region']
      world = region['world']
      region['owners'] = Owner.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['members'] = Member.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['flags'] = Flag.where("region = ? AND world = ?", region_name, world).pluck("flag")
      region['children'] = Child.where("parent = ? AND world = ?", region_name, world).pluck("child")
      parent = Child.select("parent").where("child = ? AND world = ?", region_name, world).take()

      if !parent.nil?
        region['parent'] = parent['parent']
      else
        region['parent'] = nil
      end
    end

    render :json => {
        :regions => @regions,
        :x => params[:x],
        :z => params[:z],
        :radius => @radius,
        :world => params[:world],
        :count => @count,
        :offset => params[:offset],
    }

  end

  # GET /regions/player/:player/
  # Информация о регионах игрока.
  def player
    if !params.has_key? :player
      render json: {error: "Please provide player."}, :status => 422
      return;
    end

    @regions = nil

    if params.has_key? :type
      if params[:type].eql?("owners")
        @regions = Region.select("DISTINCT `regions`.*").joins("INNER JOIN `regions_owners` ON
          (`regions_owners`.`region` = `regions`.`region` AND `regions_owners`.`world` =  `regions`.`world`)").where("`regions_owners`.`player` = ?", params[:player])
      else
        @regions = Region.select("DISTINCT `regions`.*").joins("INNER JOIN `regions_members` ON
          (`regions_members`.`region` = `regions`.`region` AND  `regions_members`.`world` =  `regions`.`world`)").where("`regions_members`.`player` = ?", params[:player])
      end
    else
      @regions = Region.select("DISTINCT `regions`.*").joins("LEFT JOIN `regions_owners` ON
         (`regions_owners`.`region` = `regions`.`region` AND `regions_owners`.`world` =  `regions`.`world`)").
          joins("LEFT JOIN `regions_members` ON (`regions_members`.`region` = `regions`.`region` AND
          `regions_members`.`world` =  `regions`.`world`)").where("`regions_owners`.`player` = ?
          OR `regions_members`.`player` = ?", params[:player], params[:player])
    end

    @regions = @regions.where("`regions`.`world` = ?", params[:world]) if params.has_key? :world

    if params.has_key? :offset
      @regions = @regions.offset(params[:offset])
    end

    if @regions.empty?
      render :json => {
          :error => "Regions not found.",
          :region => params[:region],
          :world => params[:world]
      }, :status => 422
      return;
    end

    @count = @regions.count(distinct: true)
    @regions = @regions.limit(100)

    @regions.each do |region|
      region_name = region['region']
      world = region['world']
      region['owners'] = Owner.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['members'] = Member.where("region = ? AND world = ?", region_name, world).pluck("player")
      region['flags'] = Flag.where("region = ? AND world = ?", region_name, world).pluck("flag")
      region['children'] = Child.where("parent = ? AND world = ?", region_name, world).pluck("child")
      parent = Child.select("parent").where("child = ? AND world = ?", region_name, world).take()

      if !parent.nil?
        region['parent'] = parent['parent']
      else
        region['parent'] = nil
      end
    end

    render :json => {
        :regions => @regions,
        :count => @count,
        :offset => params[:offset],
        :world => params[:world]
    }
  end

end