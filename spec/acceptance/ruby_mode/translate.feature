# encoding: utf-8
# language: ja
@javascript
機能: Translate - Rubyのソースコードからブロックに変換できる
  背景:
    前提 "Ruby" タブを表示する
    かつ すべてのブロックをクリアする

  シナリオ: Rubyのソースコードからブロックに変換する
    前提 テキストエディタにプログラムを入力済みである:
      """
      require "smalruby"

      car1 = Character.new(costume: "car1.png", x: 0, y: 0, angle: 0)

      car1.on(:start) do
        loop do
          move(10)
          turn_if_reach_wall
        end
      end

      """

    もし "ブロックタブ" にタブを切り替える
    かつ JavaScriptによるリクエストが終わるまで待つ

    ならば 次のXMLと同等のブロックが配置されていること:
      """
      <xml>
        <character x="0" y="0" name="car1" costumes="car1.png" angle="0"></character>
        <block type="character_new" x="0" y="0">
          <field name="NAME">car1</field>
          <statement name="DO">
            <block type="events_on_start">
              <statement name="DO">
                <block type="control_loop">
                  <statement name="DO">
                    <block type="motion_move" inline="true">
                      <value name="STEP">
                        <block type="math_number">
                          <field name="NUM">10</field>
                        </block>
                      </value>
                      <next>
                        <block type="motion_turn_if_reach_wall"></block>
                      </next>
                    </block>
                  </statement>
                </block>
              </statement>
            </block>
          </statement>
        </block>
      </xml>
      """

  シナリオ: Rubyのソースコードからブロックへの変換に失敗する
    前提 テキストエディタに "__FAIL__" を入力済みである

    もし "ブロックタブ" にタブを切り替える
    かつ JavaScriptによるリクエストが終わるまで待つ

    ならば ブロックが配置されていないこと
    かつ テキストエディタのプログラムは "__FAIL__" であること
