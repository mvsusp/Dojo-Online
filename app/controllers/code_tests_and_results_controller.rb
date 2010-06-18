class CodeTestsAndResultsController < ApplicationController
    #GET /rooms/room_id/code
    def show
        room = Room.find(params[:room_id])
        puts room
        code = (room.code or '')
        puts 'code' + code
        tests = (room.tests or '')
        puts 't' + tests
        res = (room.results or '')
        puts 'res' + res
        @json = ([code, tests, res]).to_json
        puts 'r' + @json
        render 'show',  :layout => false
    end
    
    #POST /rooms/room_id/code
    def create
        room = Room.find(params[:room_id])
        code = (params[:code] or '')
        tests = (params[:tests] or '')
        results = (params[:results] or '')
        room.code = code
        room.tests = tests
        room.results = results
        room.save!
    end
end
