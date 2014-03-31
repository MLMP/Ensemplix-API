class V2::LauncherController < ApplicationController

  # GET /launcher/
  # Версия лаунчера.
  def index
    @launcher_version = {launcher_version: Stat.find_by_stat('launcher_version').value}
    @launcher_jar_url = {launcher_jar_url: Stat.find_by_stat('launcher_jar_url').value}
    @launcher_exe_url = {launcher_exe_url: Stat.find_by_stat('launcher_exe_url').value}
    render json: @launcher_version.merge(@launcher_jar_url.merge(@launcher_exe_url))
  end

  # GET /launcher/libraries/
  # Библиотеки необохдимые для работы клиента.
  def libraries
    @libraries_version = {libraries_version: Stat.find_by_stat('libraries_version').value}
    @libraries_url = {libraries_url: Stat.find_by_stat('libraries_url').value}
    render json: @libraries_version.merge(@libraries_url)
  end

  # GET /launcher/mods/
  # Моды необходимые для работы клиента.
  def mods
    @mods = Mod.all
    render json: @mods
  end

  # GET /launcher/assets/
  # Дополнительые файлы необходимые для работы клиента.
  def assets
    @assets_version = {assets_version: Stat.find_by_stat('assets_version').value}
    @assets_url = {assets_url: Stat.find_by_stat('assets_url').value}
    render json: @assets_version.merge(@assets_url)
  end

end