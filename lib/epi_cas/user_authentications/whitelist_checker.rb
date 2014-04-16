module EpiCas
  module UserAuthentications
    class WhitelistChecker < Struct.new(:raw_dn, :uid)
      USER_TYPES = {
        'ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                                 => :staff,
        'ou=honorary,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_honorary,
        'ou=visiting,ou=staff,ou=users,dc=sheffield,dc=ac,dc=uk'                     => :staff_visiting,
        'ou=external,ou=users,dc=sheffield,dc=ac,dc=uk'                              => :external,
        'ou=research,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk' => :student_pg_research,
        'ou=taught,ou=postgraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'   => :student_pg_taught,
        'ou=undergraduates,ou=students,ou=users,dc=sheffield,dc=ac,dc=uk'            => :student_undergraduate
      } 
    
      def allow_authentication?
        username_whitelisted? ||
          [:staff, :staff_honorary, :staff_visiting, :external].member? type
      end
    
      def allow_creation?
        username_whitelisted? ||
          [:staff, :staff_honorary, :staff_visiting, :external].member? type
      end
    
      private
        def username_whitelisted?(setting_class = EpiCas::Settings)
          (setting_class.username_whitelist || []).member? uid.to_s.downcase
        end
        
        def type
          USER_TYPES[dn]
        end
    
        def dn
          @dn ||= raw_dn[/ou=.*dc=uk/].to_s.downcase
        end
    end
  end
end