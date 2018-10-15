# frozen_string_literal: true

require "open-uri"

module ChineseHoliday
  class HttpBase

    # 获取假期信息链接
    # 20181015 替换地址
    # BATCH_URL = "http://lanfly.vicp.io/api/holiday/batch?d="
    BATCH_URL = "http://timor.tech/api/holiday/batch?d="

    class << self

      # 调用基本接口
      #
      # @param {Symbol} method - 请求方法: get, post, patch, put 等等
      # @param {String} url - 请求地址路径
      # @param {Boolean} raw - 是否需要原始返回值
      #
      def send_request(method, url, raw = false)

        Rails.logger.info "请求方法:#{method.to_s.upcase}"
        Rails.logger.info "请求地址:#{url}"

        start_time = Time.now
        Rails.logger.info "请求开始时间:#{start_time.strftime('%Y-%m-%d %H:%M:%S')}"

        begin
          if method == :get
            response = open(url).read
          end
        rescue => e
          Rails.logger.error "请求失败原因:#{e}"
        end

        end_time = Time.now
        Rails.logger.info "请求结束时间:#{end_time.strftime('%Y-%m-%d %H:%M:%S')}"
        Rails.logger.info "请求耗时:#{end_time - start_time}秒\n"

        raw ? response : JSON.parse(response)
      end

    end

  end
end
