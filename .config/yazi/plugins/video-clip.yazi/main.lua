local M = {}

function M:peek(job)
	local gif = ya.cache(job.file.url, "video-gif")
	local thumb = ya.cache(job.file.url, "video-thumb")

	-- 1. 先尝试显示动画片段
	if fs.cha(gif) then
		ya.image_show(gif, job.area)
		return
	end

	-- 2. 如果动画还没好，立即显示静态缩略图（保证预览不消失）
	if not fs.cha(thumb) then
		-- 静默生成一张静态图
		Command("ffmpegthumbnailer"):args({ "-i", tostring(job.file.url), "-o", tostring(thumb), "-s", "480" }):spawn()
	end
	
	if fs.cha(thumb) then
		ya.image_show(thumb, job.area)
	end

	-- 3. 在后台偷偷生成片段，不阻塞界面
	self:preload(job)
end

function M:preload(job)
	local gif = ya.cache(job.file.url, "video-gif")
	if not gif or fs.cha(gif) then return 1 end

	-- 这里的生成操作不再使用 wait()，而是让它在后台跑
	Command("ffmpeg")
		:args({
			"-ss", "5",
			"-t", "5",
			"-i", tostring(job.file.url),
			"-vf", "fps=10,scale=480:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse",
			"-y",
			tostring(gif)
		})
		:spawn()
	return 1
end

function M:seek(job)
end

return M
