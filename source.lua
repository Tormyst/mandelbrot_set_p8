-- mandelbrot set
-- by raphael
function _init()
    xmin = -2.0
    xmax = 1.0
    ymin = -2.0
    ymax = 2.0
    playerx = 64
    playery = 64
    playerc = 0
    playerm = 0
    xleft = xmin
    xright = xmax
    ytop = ymax
    ybottom = ymin
    width = xright - xleft
    hight = ytop - ybottom
    xstep = width / 127.0
    ystep = hight / 127.0
    grid = {}
    for i=1,128 do
        grid[i] = {}
    end
    setmap()
end

function check(a,b)
 arr = a*a
    brr = b*b
    arr = arr + brr
    return arr < 4.0
end

function mandelbrot(xo,yo)
    it = 0
    zx = 0.0
    zy = 0.0
    while  check(zx,zy) do
        if it >= 255 then
            return 0
        end
        xtemp = (zx*zx) - (zy*zy) + xo
        zy = (2 * zx*zy) + yo
        zx = xtemp
        it = it + 1
    end
    
    return flr(it % 15)
end

function setmap()
    for x=0,127 do
        for y=0,127 do
            a = xleft+(xstep*x)
            b = ytop-(ystep*y)
            grid[x+1][y+1] = mandelbrot(a,b)
        end
    end
end

function _update()
    if (btn(0) and playerx > 0) playerx -= 1
    if (btn(1) and playerx < 127) playerx += 1
    if (btn(2) and playery > 0) playery -= 1
    if (btn(3) and playery < 127) playery += 1
    playerc = (playerc + 1) % 16
    if btn(5) then
        xleft = xleft+(xstep*(playerx - 2))
        xright = xleft + (xstep*5)
        ytop = ytop-(ystep*(playery - 2))
        ybottom = ytop - (ystep*5)
        width = xright - xleft
        hight = ytop - ybottom
        xstep = width / 127.0
        ystep = hight / 127.0
        setmap()
    end
end

function _draw()
    for x=0,127 do
        for y=0,127 do
         pset(x,y,grid[x+1][y+1])
        end
    end
    if (playerm) circ(playerx,playery,1,playerc)
end
